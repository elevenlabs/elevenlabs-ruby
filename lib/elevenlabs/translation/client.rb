# frozen_string_literal: true

module Elevenlabs
  module Translation
    class Client
      def initialize(client:)
        @client = client
      end

      # Opens a WebSocket connection to the `translation` channel.
      #
      # @param target_language [String]
      # @param voice_id [String]
      # @param authorization [String, nil]
      # @param source_language [String, nil]
      # @param input_format [Elevenlabs::V1TranslationRealtime::Types::TranslationRealtimeInputFormat, nil]
      # @param output_format [Elevenlabs::V1TranslationRealtime::Types::TranslationRealtimeOutputFormat, nil]
      # @param tts_model_id [Elevenlabs::V1TranslationRealtime::Types::TranslationRealtimeTtsModelID, nil]
      # @param apply_text_normalization [Elevenlabs::V1TranslationRealtime::Types::TranslationRealtimeApplyTextNormalization, nil]
      # @param eagerness [Elevenlabs::V1TranslationRealtime::Types::TranslationRealtimeEagerness, nil]
      # @param client_session_id [String, nil]
      # @param enable_zrm [Elevenlabs::Internal::Types::Boolean, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [TranslationSocket] The connected socket; it is closed when the block returns.
      # @return [TranslationSocket, Object] The connected socket, or the block's value when a block is given.
      def realtime(target_language:, voice_id:, authorization: nil, source_language: nil, input_format: nil, output_format: nil, tts_model_id: nil, apply_text_normalization: nil, eagerness: nil, client_session_id: nil, enable_zrm: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        TranslationSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: '/v1/translation/realtime',
            query: { 'target_language' => target_language, 'voice_id' => voice_id, 'authorization' => authorization, 'source_language' => source_language, 'input_format' => input_format, 'output_format' => output_format, 'tts_model_id' => tts_model_id, 'apply_text_normalization' => apply_text_normalization, 'eagerness' => eagerness, 'client_session_id' => client_session_id, 'enable_zrm' => enable_zrm },
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
