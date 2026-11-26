# frozen_string_literal: true

module Elevenlabs
  module Subtitling
    class Client
      def initialize(client:)
        @client = client
      end

      # Opens a WebSocket connection to the `subtitling` channel.
      #
      # @param target_language [String]
      # @param source_language [String, nil]
      # @param input_format [Elevenlabs::V1SubtitlingRealtime::Types::SubtitlingRealtimeInputFormat, nil]
      # @param eagerness [Elevenlabs::V1SubtitlingRealtime::Types::SubtitlingRealtimeEagerness, nil]
      # @param client_session_id [String, nil]
      # @param enable_logging [Elevenlabs::Internal::Types::Boolean, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [SubtitlingSocket] The connected socket; it is closed when the block returns.
      # @return [SubtitlingSocket, Object] The connected socket, or the block's value when a block is given.
      def realtime(target_language:, source_language: nil, input_format: nil, eagerness: nil, client_session_id: nil, enable_logging: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        SubtitlingSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: '/v1/subtitling/realtime',
            query: { 'target_language' => target_language, 'source_language' => source_language, 'input_format' => input_format, 'eagerness' => eagerness, 'client_session_id' => client_session_id, 'enable_logging' => enable_logging },
            client_query: @client.websocket_query,
            request_options: request_options,
          ),
          headers: -> { ::Elevenlabs::Internal::WebSocket::Handshake.headers(client_headers: @client.websocket_headers, credentials: -> { @client.websocket_credentials }, request_options: request_options) },
          reconnect: reconnect,
          connect_timeout: connect_timeout,
          &block
        )
      end
    end
  end
end
