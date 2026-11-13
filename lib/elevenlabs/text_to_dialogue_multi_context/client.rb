# frozen_string_literal: true

module Elevenlabs
  module TextToDialogueMultiContext
    class Client
      def initialize(client:)
        @client = client
      end

      # Opens a WebSocket connection to the `text_to_dialogue_multi_context` channel.
      #
      # @param model_id [String, nil]
      # @param output_format [String, nil]
      # @param language_code [String, nil]
      # @param sync_alignment [Elevenlabs::Internal::Types::Boolean, nil]
      # @param apply_text_normalization [Elevenlabs::V1TextToDialogueMultiStreamInput::Types::TextToDialogueMultiContextRealtimeApplyTextNormalization, nil]
      # @param seed [Integer, nil]
      # @param enable_logging [Elevenlabs::Internal::Types::Boolean, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [TextToDialogueMultiContextSocket] The connected socket; it is closed when the block returns.
      # @return [TextToDialogueMultiContextSocket, Object] The connected socket, or the block's value when a block is given.
      def realtime(model_id: nil, output_format: nil, language_code: nil, sync_alignment: nil, apply_text_normalization: nil, seed: nil, enable_logging: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        TextToDialogueMultiContextSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: '/v1/text-to-dialogue/multi-stream-input',
            query: { 'model_id' => model_id, 'output_format' => output_format, 'language_code' => language_code, 'sync_alignment' => sync_alignment, 'apply_text_normalization' => apply_text_normalization, 'seed' => seed, 'enable_logging' => enable_logging },
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
