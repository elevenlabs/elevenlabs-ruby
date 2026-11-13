# frozen_string_literal: true

require 'json'
require 'monitor'

module Elevenlabs
  module Internal
    module WebSocket
      # @api private
      #
      # What every generated channel socket shares. A socket starts out queueing what it receives
      # for `#recv` and `#each`. `#start_listening` switches it to the handlers registered with
      # `#on`: the queued events go to them first, then every later event, on the reader thread.
      module Channel
        EVENTS = %i[open message error close raw unknown].freeze
        NOT_JSON = Object.new.freeze
        STREAM_END = Object.new.freeze
        NO_HANDLERS = [].freeze

        def self.included(base)
          base.extend(ClassMethods)
        end

        # Opening a socket.
        module ClassMethods
          # Connects a socket. With a block, yields it and closes it when the block returns.
          #
          # @param url [String] The `ws://` or `wss://` URL to open.
          # @param headers [Hash{String=>String}, #call] See `Connection#initialize`.
          # @param reconnect [Hash, true, nil] See `Connection#initialize`.
          # @param connect_timeout [Numeric, nil] See `Connection#initialize`.
          # @return [Object] The connected socket, or the block's value when a block is given.
          def connect(url:, headers: {}, reconnect: nil, connect_timeout: nil)
            socket = new(url: url, headers: headers, reconnect: reconnect, connect_timeout: connect_timeout).connect
            return socket unless block_given?

            begin
              yield socket
            ensure
              socket.close
            end
          end
        end

        # @param url [String] The `ws://` or `wss://` URL to open.
        # @param headers [Hash{String=>String}, #call] See `Connection#initialize`.
        # @param reconnect [Hash, true, nil] See `Connection#initialize`.
        # @param connect_timeout [Numeric, nil] See `Connection#initialize`.
        def initialize(url:, headers: {}, reconnect: nil, connect_timeout: nil)
          @handlers = {}
          @events = Thread::Queue.new
          @lock = Monitor.new
          @listening = false
          @connection = Connection.new(
            url: url,
            headers: headers,
            reconnect: reconnect,
            connect_timeout: connect_timeout,
            handlers: {
              text: ->(text) { receive(*decode(text)) },
              binary: ->(bytes) { receive(:message, bytes) },
              close: ->(code, reason) { receive(:close, code, reason) },
              error: ->(error) { receive(:error, error) },
            },
          )
        end

        # Opens the connection and blocks until the server accepts the handshake.
        #
        # @raise [::Elevenlabs::Errors::WebSocketHandshakeError] The server refused the handshake.
        # @raise [::Elevenlabs::Errors::ConnectionError] The server could not be reached.
        # @raise [::Elevenlabs::Errors::TimeoutError] The handshake took longer than the connect timeout.
        # @return [self]
        def connect
          @connection.connect
          self
        end

        # @return [Symbol] One of `:connecting`, `:open`, `:closing` or `:closed`.
        def state
          @connection.state
        end

        # Registers a handler for one of `:open`, `:message`, `:error`, `:close`, `:raw` (a text
        # frame that is not JSON) or `:unknown` (JSON no declared message matches). Handlers run
        # once `#start_listening` is called. A handler that raises does not stop the socket: the
        # exception goes to the `:error` handlers, and one raised by an `:error` handler is printed
        # as a warning.
        #
        # @param event [Symbol]
        # @return [self]
        def on(event, &handler)
          raise ArgumentError, "Unknown WebSocket event #{event.inspect}; expected one of #{EVENTS.join(', ')}" unless EVENTS.include?(event)

          @lock.synchronize { @handlers[event] = [*@handlers[event], handler] }
          self
        end

        # Hands every event received so far, then every later one, to the registered handlers,
        # starting with `:open`. From then on `#recv` answers nil and `#each` stops, including a
        # call already waiting on another thread.
        #
        # @return [self]
        def start_listening
          emit(:open)
          while (event = next_queued_event)
            emit(*event)
          end
          self
        end

        # Waits for the next message.
        #
        # @param timeout [Numeric, nil] Seconds to wait; nil waits until the connection closes.
        # @return [Object, nil] The message, or nil when the timeout passes or the connection closes.
        def recv(timeout: nil)
          message = next_message(timeout)
          message.equal?(STREAM_END) ? nil : message
        end

        # Yields each message until the connection closes.
        #
        # @return [Enumerator, nil] An enumerator when no block is given.
        def each
          return enum_for(:each) unless block_given?

          loop do
            message = next_message(nil)
            break if message.equal?(STREAM_END)

            yield message
          end
        end

        # Sends a string as a text frame, and anything else as JSON.
        #
        # @param message [String, Hash, Array, ::Elevenlabs::Internal::Types::Model, Object]
        # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
        # @return [void]
        def send(message)
          message.is_a?(::String) ? send_text(message) : send_json(message)
        end

        # Sends bytes as a binary frame.
        #
        # @param bytes [String]
        # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
        # @return [void]
        def send_binary(bytes)
          @connection.send_binary(bytes)
        end

        # Closes the connection.
        #
        # @param code [Integer]
        # @param reason [String]
        # @return [void]
        def close(code: 1000, reason: '')
          @connection.close(code, reason)
        end

        private

        def send_text(text)
          @connection.send_text(text)
        end

        def send_json(message)
          payload = message.is_a?(Types::Model) ? message.to_h : message
          @connection.send_text(::JSON.generate(payload))
        end

        def parse_json(text)
          ::JSON.parse(text)
        rescue ::JSON::ParserError
          NOT_JSON
        end

        def match_json(data, receive_types, union_types)
          receive_types.each do |type, literals, present|
            return [:message, type.coerce(data)] if matches?(data, literals, present)
          end
          union_types.each do |type|
            value = type.coerce(data)
            return [:message, value] unless value.equal?(data)
          end
          nil
        end

        def matches?(data, literals, present)
          data.is_a?(::Hash) &&
            literals.all? { |name, value| data[name] == value } &&
            present.all? { |name| data.key?(name) }
        end

        def receive(event, *args)
          listening = @lock.synchronize do
            @events << [event, *args] unless @listening
            @listening
          end
          emit(event, *args) if listening
        end

        def next_queued_event
          @lock.synchronize do
            next @events.pop unless @events.empty?

            @listening = true
            @events.close
            nil
          end
        end

        def next_message(timeout)
          deadline = timeout && (monotonic_now + timeout)
          loop do
            remaining = deadline && [deadline - monotonic_now, 0].max
            event, *args = @events.pop(timeout: remaining)
            return STREAM_END if event.nil?

            case event
            when :message, :raw
              return args.first
            when :close
              requeue(event, *args)
              return STREAM_END
            end
          end
        end

        def requeue(event, *args)
          @events << [event, *args]
        rescue ::ClosedQueueError
          nil
        end

        def monotonic_now
          Process.clock_gettime(Process::CLOCK_MONOTONIC)
        end

        def emit(event, *args)
          @lock.synchronize { @handlers.fetch(event, NO_HANDLERS) }.each do |handler|
            handler.call(*args)
          rescue StandardError => e
            handler_failed(event, e)
          end
        end

        def handler_failed(event, error)
          return emit(:error, error) unless event == :error

          warn("#{self.class}: an :error handler raised #{error.class}: #{error.message}")
        end
      end
    end
  end
end
