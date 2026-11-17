# frozen_string_literal: true

require 'socket'
require 'websocket/driver'
require_relative 'session'
require_relative 'jwt_verifier'

module Elevenlabs
  module SpeechEngine
    # Standalone WebSocket server that produces a {Session} for each inbound
    # connection from the ElevenLabs Speech Engine API.
    #
    # Every connection is verified against the API key (the
    # +X-ElevenLabs-Speech-Engine-Authorization+ JWT) before its session is wired
    # up, unless +disable_auth+ is set. Built on +websocket-driver+ (already a
    # dependency of this SDK) and a plain +TCPServer+, so it owns its own accept
    # loop — call {#serve} from a long-running worker process, not a web request.
    #
    # Hand-written (see +.fernignore+), mirroring +SpeechEngineServer+ in the
    # PHP/Python/TS SDKs. Like PHP, the shape is a standalone {#serve}: there is no
    # attach-to-an-existing-HTTP-server variant.
    #
    # The header name arrives parsed into the WEBrick/Rack-style env key
    # +HTTP_X_ELEVENLABS_SPEECH_ENGINE_AUTHORIZATION+.
    AUTH_ENV_KEY = 'HTTP_X_ELEVENLABS_SPEECH_ENGINE_AUTHORIZATION'

    class Server
      READ_CHUNK = 4096

      # A connection that has been accepted but has not finished the WebSocket
      # handshake is dropped after this many seconds, so an unauthenticated client
      # that opens a socket and sends nothing cannot pin a thread and file
      # descriptor indefinitely.
      HANDSHAKE_TIMEOUT = 10

      # Upper bound on concurrent accepted connections. Beyond it, new sockets are
      # closed immediately rather than each getting an unbounded worker thread.
      MAX_CONNECTIONS = 1024

      # @return [Integer, nil] The port the server actually bound to, set once
      #   {#serve} starts listening. Useful when +port: 0+ lets the OS assign one.
      attr_reader :bound_port

      # @param port [Integer] TCP port to listen on.
      # @param path [String, nil] If set, only connections to this request path are accepted.
      # @param api_key [String, nil] Account API key. Falls back to +ENV['ELEVENLABS_API_KEY']+.
      # @param debug [Boolean] When true, logs activity to $stderr.
      # @param disable_auth [Boolean] Skip JWT verification. Only behind an IP allowlist.
      # @param handlers [Hash] Event handlers wired onto each session, keyed by
      #   +:on_init+, +:on_transcript+, +:on_close+, +:on_disconnect+, +:on_error+.
      # @param handshake_timeout [Numeric] Seconds a connection has to complete the
      #   WebSocket handshake before it is dropped. Defaults to {HANDSHAKE_TIMEOUT}.
      # @param max_connections [Integer] Maximum concurrent accepted connections.
      #   Defaults to {MAX_CONNECTIONS}.
      def initialize(port: 3001, path: nil, api_key: nil, debug: false, disable_auth: false, handlers: {},
                     handshake_timeout: HANDSHAKE_TIMEOUT, max_connections: MAX_CONNECTIONS)
        @port = port
        @path = path
        @api_key = api_key
        @debug = debug
        @disable_auth = disable_auth
        @handlers = handlers
        @handshake_timeout = handshake_timeout
        @max_connections = max_connections
        @running = false
        @tcp_server = nil
        @mutex = Mutex.new
        # Open connection sockets (accepted, not yet finished). Guarded by @mutex
        # so {#stop} can drain them and new connections are refused once stopping.
        @connections = {}
      end

      # Start the server. Blocks until {#stop} is called.
      #
      # @raise [RuntimeError] If no API key is available and auth is not disabled.
      def serve
        api_key = resolve_api_key
        if api_key.nil? && !@disable_auth
          raise 'SpeechEngineServer requires an API key to verify incoming connections. ' \
                'Pass api_key: or set the ELEVENLABS_API_KEY environment variable. To run without ' \
                'authentication, pass disable_auth: true — but only behind an IP allowlist.'
        end
        if @disable_auth
          warn(
            '[SpeechEngine] authentication is disabled — incoming connections will NOT be verified. ' \
            'Make sure the server is protected by an IP allowlist restricting traffic to ElevenLabs.',
          )
        end

        listener = TCPServer.new(@port)
        @tcp_server = listener
        @bound_port = listener.addr[1]
        @mutex.synchronize { @running = true }
        log("speech engine server listening on port #{@bound_port}")

        # Use a local reference: stop() closes the listener and nils @tcp_server, and reading the
        # nil'd ivar here would raise NoMethodError (which the rescue below does not cover). The
        # local still points at the now-closed socket, so accept follows the normal IO-error path.
        loop do
          begin
            io = listener.accept
          rescue IOError, Errno::EBADF
            break
          end

          admitted = @mutex.synchronize do
            if @running && @connections.size < @max_connections
              @connections[io] = true
              true
            else
              false
            end
          end
          unless admitted
            log('refused connection — server stopping or at capacity') unless @running
            close_io(io)
            next
          end

          Thread.new(io) { |conn| handle_connection(conn, api_key) }
        end
      ensure
        @mutex.synchronize { @running = false }
        close_listener
        drain_connections
        @bound_port = nil
      end

      # Signal the server to stop accepting connections and shut down. Closes the
      # listening socket and every open connection, which unblocks their reader
      # threads so they finish and fire +disconnected+.
      def stop
        @mutex.synchronize { @running = false }
        close_listener
        drain_connections
      end

      # Wrap a websocket-driver connection in a session with this server's handlers
      # wired up. +send+, +close+ and +transcript_executor+ override the defaults so
      # the bundled server can serialize writes and run handlers off the reader
      # thread; left unset, the session talks to the driver directly and runs
      # handlers inline.
      def create_session(driver, send: nil, close: nil, transcript_executor: nil)
        session = Session.new(
          send: send || ->(text) { driver.text(text) },
          close: close || -> { driver.close },
          transcript_executor: transcript_executor,
          debug: @debug,
        )
        wire_handlers(session)
        session
      end

      private

      def resolve_api_key
        key = @api_key
        key = ENV.fetch('ELEVENLABS_API_KEY', nil) if key.nil? || key.empty?
        key = nil if key && key.empty?
        key
      end

      def handle_connection(io, api_key)
        driver = ::WebSocket::Driver.server(io)
        session = nil
        opened = false
        # websocket-driver is not safe for concurrent writes, so every outbound
        # driver call (handshake, pong, agent_response, close) is serialized here.
        # Protocol-level WebSocket control frames auto-answered inside driver.parse
        # are not covered, but the Speech Engine protocol signals ping/close as
        # JSON text frames, not WebSocket control frames.
        driver_mutex = Mutex.new
        # One worker thread per connection runs transcript handlers serially, so a
        # slow send_response stream never blocks the reader from answering ping or
        # close frames (see Session's transcript_executor).
        jobs = Thread::Queue.new
        worker = Thread.new do
          while (job = jobs.pop)
            break if job == :stop

            begin
              job.call
            rescue StandardError => e
              log("transcript worker error — #{e.message}")
            end
          end
        end

        driver.on(:connect) do
          if accept_handshake?(driver, api_key)
            driver_mutex.synchronize { driver.start }
          else
            close_io(io)
          end
        end
        driver.on(:open) do
          opened = true
          session = create_session(
            driver,
            send: ->(text) { driver_mutex.synchronize { driver.text(text) } },
            close: -> { driver_mutex.synchronize { driver.close } },
            transcript_executor: ->(job) { jobs << job },
          )
        end
        driver.on(:message) { |event| session&.handle_raw_message(event.data) }
        driver.on(:close) do
          session&.handle_disconnect
          close_io(io)
        end

        read_loop(io, driver, -> { opened })
      rescue StandardError => e
        log("connection error — #{e.message}")
      ensure
        jobs << :stop
        worker.join(1)
        worker.kill if worker.alive?
        session&.handle_disconnect
        close_io(io)
        @mutex.synchronize { @connections.delete(io) }
      end

      def accept_handshake?(driver, api_key)
        env = driver.env
        if @path && env['PATH_INFO'] != @path
          log("rejected connection — path mismatch: expected #{@path}, got #{env['PATH_INFO']}")
          return false
        end
        return true if @disable_auth

        header = env[AUTH_ENV_KEY].to_s
        if header.empty?
          log("rejected connection — missing #{AUTH_ENV_KEY}")
          return false
        end
        begin
          JwtVerifier.verify(header, api_key.to_s)
        rescue StandardError => e
          log("rejected connection — #{e.message}")
          return false
        end
        log('verified connection, creating session')
        true
      end

      # Read frames until the connection drops, the server stops, or (before the
      # handshake completes) the handshake deadline passes. IO.select bounds the
      # blocking read so both the deadline and {#stop} are honoured promptly.
      def read_loop(io, driver, opened)
        handshake_deadline = Time.now + @handshake_timeout
        loop do
          break unless @running

          if opened.call
            timeout = 1.0
          else
            timeout = handshake_deadline - Time.now
            if timeout <= 0
              log('dropped connection — handshake not completed in time')
              break
            end
          end

          next if io.wait_readable(timeout).nil?

          data = io.readpartial(READ_CHUNK)
          driver.parse(data)
        rescue IOError, Errno::ECONNRESET, Errno::EBADF
          break
        end
      end

      def wire_handlers(session)
        {
          on_init: 'init',
          on_transcript: 'user_transcript',
          on_close: 'close',
          on_disconnect: 'disconnected',
          on_error: 'error',
        }.each do |key, event|
          handler = @handlers[key]
          session.on(event, handler) if handler
        end
      end

      def close_listener
        @tcp_server&.close
      rescue IOError
        # already closed
      ensure
        @tcp_server = nil
      end

      def drain_connections
        conns = @mutex.synchronize do
          keys = @connections.keys
          @connections.clear
          keys
        end
        conns.each { |io| close_io(io) }
      end

      def close_io(io)
        io.close
      rescue IOError
        # already closed
      end

      def log(message)
        warn("[SpeechEngine] #{message}") if @debug
      end
    end
  end
end
