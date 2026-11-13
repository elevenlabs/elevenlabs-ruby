# frozen_string_literal: true

require 'io/wait'
require 'openssl'
require 'socket'
require 'uri'
require 'websocket/driver'

module Elevenlabs
  module Internal
    module WebSocket
      # @api private
      #
      # One WebSocket connection: a TCP or TLS socket, the `websocket-driver` protocol engine and a
      # reader thread. Frames, the close and any failure after the handshake are reported to the
      # handlers given to `#initialize`, on the reader thread.
      #
      # With reconnection on, a connection the server closes or drops is opened again with the same
      # URL and freshly resolved headers, after an exponential backoff, and neither the loss nor the
      # reconnect is reported. A send made while it reconnects waits for it. When every retry fails,
      # the last failure is reported on `:error`, then the close.
      class Connection
        READ_CHUNK_BYTES = 16_384
        CLOSE_WAIT_SECONDS = 5
        DEFAULT_CONNECT_TIMEOUT = 5
        DEFAULT_RECONNECT = { max_retries: 5, backoff: 1.0, max_backoff: 30.0 }.freeze
        NORMAL_CLOSURE = 1000
        ABNORMAL_CLOSURE = 1006
        TRANSPORT_ERRORS = [::EOFError, ::IOError, ::SystemCallError, ::OpenSSL::SSL::SSLError].freeze
        NO_HANDLER = ->(*) {}

        # The socket `websocket-driver` writes frames through.
        class Transport
          # @return [String]
          attr_reader :url

          # @param url [String]
          # @param io [IO]
          def initialize(url, io)
            @url = url
            @io = io
          end

          # @param data [String]
          # @return [void]
          def write(data)
            @io.write(data)
          end
        end

        # @return [Symbol] One of the `State` values.
        attr_reader :state
        # @return [Integer, nil] The close code, once the connection has closed.
        attr_reader :close_code
        # @return [String, nil] The close reason, once the connection has closed.
        attr_reader :close_reason

        # @param url [String] The `ws://` or `wss://` URL to open.
        # @param headers [Hash{String=>String}, #call] Headers sent with the opening handshake, or a
        #   callable returning them, called before every attempt so a reconnect sends current
        #   credentials.
        # @param handlers [Hash{Symbol=>#call}] Callbacks for `:open`, `:text`, `:binary`,
        #   `:close` (called with the code and reason) and `:error`.
        # @param reconnect [Hash, true, nil] Reconnects after the server closes or drops the
        #   connection: `:max_retries` (default 5), `:backoff`, the first delay in seconds (default
        #   1.0, doubling each retry) and `:max_backoff` (default 30.0). `true` takes the defaults; nil
        #   or false leaves reconnection off.
        # @param connect_timeout [Numeric, nil] Seconds to wait for the socket and the handshake;
        #   DEFAULT_CONNECT_TIMEOUT when nil.
        def initialize(url:, headers: {}, handlers: {}, reconnect: nil, connect_timeout: nil)
          @url = url
          @headers = headers
          @handlers = handlers
          @reconnect = reconnect_policy(reconnect)
          @connect_timeout = connect_timeout || DEFAULT_CONNECT_TIMEOUT
          @lock = Mutex.new
          @changed = ConditionVariable.new
          @pending = []
          @state = State::CONNECTING
          @reconnecting = false
          @closing = false
        end

        # Opens the connection and blocks until the server accepts the handshake.
        #
        # @raise [::Elevenlabs::Errors::WebSocketHandshakeError] The server refused the handshake.
        # @raise [::Elevenlabs::Errors::ConnectionError] The server could not be reached.
        # @raise [::Elevenlabs::Errors::TimeoutError] The handshake took longer than the connect timeout.
        # @return [self]
        def connect
          opened = establish
          @reader = Thread.new { run }
          deliver(reportable(opened))
          self
        end

        # @param text [String]
        # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
        # @return [void]
        def send_text(text)
          write_frame { @driver.text(text.to_s) }
        end

        # @param bytes [String]
        # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
        # @return [void]
        def send_binary(bytes)
          write_frame { @driver.binary(bytes.b) }
        end

        # Sends a close frame and waits for the server to answer it. A reconnect under way is
        # abandoned, and a send waiting for it fails.
        #
        # @param code [Integer]
        # @param reason [String]
        # @return [void]
        def close(code = NORMAL_CLOSURE, reason = '')
          outcome = @lock.synchronize do
            @closing = true
            if @state == State::OPEN
              @state = State::CLOSING
              @driver.close(reason, code)
              :awaiting_server
            elsif @reconnecting
              settle(State::CLOSED)
              :abandoned
            end
          end
          await_reader if outcome == :awaiting_server
          deliver([[:close, code, reason]]) if outcome == :abandoned
        end

        private

        def reconnect_policy(reconnect)
          return nil unless reconnect

          DEFAULT_RECONNECT.merge(reconnect == true ? {} : reconnect.to_h.transform_keys(&:to_sym))
        end

        def establish
          uri = URI.parse(@url)
          deadline = monotonic_now + @connect_timeout
          @lock.synchronize { @state = State::CONNECTING unless @reconnecting }
          headers = handshake_headers
          @io = open_socket(uri, deadline)
          @driver = build_driver(headers)
          await_handshake(uri, deadline)
        end

        def run
          read_frames
          read_frames while reconnected?
        end

        def reconnected?
          return false unless reconnecting?

          failure = nil
          @reconnect[:max_retries].times do |attempt|
            return false unless await_backoff(attempt)

            begin
              opened = establish
            rescue StandardError => e
              failure = e
              next
            end
            return abandon_reconnect if @lock.synchronize { @state == State::CLOSED }

            deliver(reportable(opened))
            return true
          end
          give_up(failure)
        end

        def await_backoff(attempt)
          delay = [@reconnect[:backoff] * (2**attempt), @reconnect[:max_backoff]].min
          deadline = monotonic_now + delay
          @lock.synchronize do
            while @reconnecting && (left = deadline - monotonic_now).positive?
              @changed.wait(@lock, left)
            end
            @reconnecting
          end
        end

        def reconnecting?
          @lock.synchronize { @reconnecting }
        end

        def abandon_reconnect
          @io.close unless @io.closed?
          false
        end

        def give_up(failure)
          @lock.synchronize { settle(State::CLOSED) }
          reason = "The WebSocket connection could not be reopened after #{@reconnect[:max_retries]} attempts"
          reason = "#{reason}: #{failure.message}" if failure
          deliver([
                    [:error, ::Elevenlabs::Errors::WebSocketError.new(reason)],
                    [:close, @close_code || ABNORMAL_CLOSURE, @close_reason || reason],
                  ])
          false
        end

        def settle(state)
          @state = state
          @reconnecting = false
          @changed.broadcast
        end

        def handshake_headers
          @headers.respond_to?(:call) ? @headers.call : @headers
        rescue StandardError
          fail_connecting
          raise
        end

        def open_socket(uri, deadline)
          tcp = ::Socket.tcp(uri.hostname, uri.port, connect_timeout: remaining(deadline))
          uri.scheme == 'wss' ? wrap_tls(tcp, uri.hostname) : tcp
        rescue ::Errno::ETIMEDOUT, ::IO::TimeoutError
          fail_connecting
          raise ::Elevenlabs::Errors::TimeoutError,
                "Timed out after #{@connect_timeout}s connecting to the WebSocket server at #{uri.hostname}:#{uri.port}."
        rescue ::SocketError, *TRANSPORT_ERRORS => e
          fail_connecting
          raise ::Elevenlabs::Errors::ConnectionError,
                "Could not reach the WebSocket server at #{uri.hostname}:#{uri.port}: #{e.message}"
        end

        def fail_connecting
          @lock.synchronize { @state = State::CLOSED unless @reconnecting }
        end

        def remaining(deadline)
          [deadline - monotonic_now, 0].max
        end

        def monotonic_now
          Process.clock_gettime(Process::CLOCK_MONOTONIC)
        end

        def wrap_tls(tcp, hostname)
          context = OpenSSL::SSL::SSLContext.new
          context.set_params(verify_mode: OpenSSL::SSL::VERIFY_PEER)
          tls = OpenSSL::SSL::SSLSocket.new(tcp, context)
          tls.hostname = hostname
          tls.sync_close = true
          tls.connect
          tls.post_connection_check(hostname)
          tls
        end

        def build_driver(headers)
          driver = ::WebSocket::Driver.client(Transport.new(@url, @io))
          headers.each { |name, value| driver.set_header(name, value) }
          driver.on(:open) { @pending << [:open] }
          driver.on(:message) { |event| @pending << message_event(event.data) }
          driver.on(:close) { |event| @pending << [:close, event.code, event.reason] }
          driver.on(:error) { |error| @pending << [:error, error] }
          driver
        end

        def message_event(data)
          return [:binary, data.pack('C*')] if data.is_a?(::Array)

          data.encoding == Encoding::BINARY ? [:binary, data] : [:text, data]
        end

        def await_handshake(uri, deadline)
          @lock.synchronize { @driver.start }
          loop do
            raise handshake_timeout(uri) unless readable_before?(deadline)

            events = parse(@io.readpartial(READ_CHUNK_BYTES))
            opened_at = events.index { |type, *| type == :open }
            return events.drop(opened_at) if opened_at

            failure = events.find { |type, *| type == :error }
            raise refused_handshake(failure.last) if failure
          end
        rescue *TRANSPORT_ERRORS => e
          fail_connecting
          @io.close
          raise ::Elevenlabs::Errors::ConnectionError,
                "The WebSocket server at #{uri.hostname}:#{uri.port} dropped the handshake: #{e.message}"
        end

        def readable_before?(deadline)
          return true if @io.respond_to?(:pending) && @io.pending.positive?

          !@io.to_io.wait_readable(remaining(deadline)).nil?
        end

        def handshake_timeout(uri)
          fail_connecting
          @io.close
          ::Elevenlabs::Errors::TimeoutError.new(
            "Timed out after #{@connect_timeout}s waiting for the WebSocket handshake with #{uri.hostname}:#{uri.port}.",
          )
        end

        def refused_handshake(error)
          status = @driver.status
          fail_connecting
          @io.close
          message = if status
                      "The server refused the WebSocket handshake with HTTP #{status}."
                    else
                      "The WebSocket handshake failed: #{error.message}"
                    end
          ::Elevenlabs::Errors::WebSocketHandshakeError.new(message, status_code: status)
        end

        def parse(chunk)
          @lock.synchronize do
            @driver.parse(chunk)
            events = @pending.slice!(0..)
            events.each { |event| transition(*event) }
            events
          end
        end

        def transition(type, code = nil, reason = nil)
          case type
          when :open
            settle(State::OPEN) unless @closing
          when :close
            @close_code = code
            @close_reason = reason
            lose_connection
          end
        end

        def lose_connection
          if @reconnect && !@closing
            @state = State::CONNECTING
            @reconnecting = true
          else
            settle(State::CLOSED)
          end
        end

        def read_frames
          loop do
            events = parse(@io.readpartial(READ_CHUNK_BYTES))
            deliver(reportable(events))
            break if events.any? { |type, *| type == :close }
          end
        rescue *TRANSPORT_ERRORS => e
          drop("The WebSocket connection dropped: #{e.message}")
        ensure
          @io.close unless @io.closed?
        end

        def reportable(events)
          return events unless reconnecting?

          events.reject { |type, *| type == :close }
        end

        def write_frame
          @lock.synchronize do
            @changed.wait(@lock) while @reconnecting
            raise ::Elevenlabs::Errors::WebSocketError, 'The WebSocket connection is not open.' unless @state == State::OPEN

            yield
          end
        rescue *TRANSPORT_ERRORS => e
          raise ::Elevenlabs::Errors::WebSocketError, "The WebSocket connection dropped while sending: #{e.message}"
        end

        def await_reader
          return if @reader.nil? || Thread.current == @reader
          return if @reader.join(CLOSE_WAIT_SECONDS)

          drop('The server did not answer the close in time.', report: false)
          @io.close unless @io.closed?
        end

        def drop(reason, report: true)
          dropped = @lock.synchronize do
            next false if @state == State::CLOSED || @reconnecting

            transition(:close, ABNORMAL_CLOSURE, reason)
            !@reconnecting
          end
          return unless dropped

          events = [[:close, ABNORMAL_CLOSURE, reason]]
          events.unshift([:error, ::Elevenlabs::Errors::WebSocketError.new(reason)]) if report
          deliver(events)
        end

        def deliver(events)
          events.each do |type, *args|
            @handlers.fetch(type, NO_HANDLER).call(*args)
          end
        end
      end
    end
  end
end
