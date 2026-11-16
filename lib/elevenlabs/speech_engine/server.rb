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
      def initialize(port: 3001, path: nil, api_key: nil, debug: false, disable_auth: false, handlers: {})
        @port = port
        @path = path
        @api_key = api_key
        @debug = debug
        @disable_auth = disable_auth
        @handlers = handlers
        @running = false
        @tcp_server = nil
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

        @tcp_server = TCPServer.new(@port)
        @bound_port = @tcp_server.addr[1]
        @running = true
        log("speech engine server listening on port #{@bound_port}")

        loop do
          begin
            io = @tcp_server.accept
          rescue IOError, Errno::EBADF
            break
          end
          break unless @running

          Thread.new(io) { |conn| handle_connection(conn, api_key) }
        end
      ensure
        @running = false
        begin
          @tcp_server&.close
        rescue IOError
          # already closed
        end
        @tcp_server = nil
        @bound_port = nil
      end

      # Signal the server to stop accepting connections and shut down.
      def stop
        @running = false
        begin
          @tcp_server&.close
        rescue IOError
          # already closed
        end
      end

      # Wrap a websocket-driver connection in a session with this server's handlers
      # wired up.
      def create_session(driver)
        session = Session.new(
          send: ->(text) { driver.text(text) },
          close: -> { driver.close },
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

        driver.on(:connect) do
          if accept_handshake?(driver, api_key)
            driver.start
          else
            close_io(io)
          end
        end
        driver.on(:open) { session = create_session(driver) }
        driver.on(:message) { |event| session&.handle_raw_message(event.data) }
        driver.on(:close) do
          session&.handle_disconnect
          close_io(io)
        end

        read_loop(io, driver)
      rescue StandardError => e
        log("connection error — #{e.message}")
      ensure
        session&.handle_disconnect
        close_io(io)
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

      def read_loop(io, driver)
        loop do
          data = io.readpartial(READ_CHUNK)
          driver.parse(data)
        rescue IOError, Errno::ECONNRESET
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
