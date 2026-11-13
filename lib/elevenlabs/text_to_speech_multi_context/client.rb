# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module TextToSpeechMultiContext
    class Client
      def initialize(client:)
        @client = client
      end

      # Opens a WebSocket connection to the `text_to_speech_multi_context` channel.
      #
      # @param voice_id [String]
      # @param authorization [String, nil]
      # @param single_use_token [String, nil]
      # @param model_id [String, nil]
      # @param language_code [String, nil]
      # @param enable_logging [Elevenlabs::Internal::Types::Boolean, nil]
      # @param output_format [String, nil]
      # @param inactivity_timeout [Integer, nil]
      # @param sync_alignment [Elevenlabs::Internal::Types::Boolean, nil]
      # @param auto_mode [Elevenlabs::Internal::Types::Boolean, nil]
      # @param apply_text_normalization [Elevenlabs::V1TextToSpeechVoiceIDMultiStreamInput::Types::TextToSpeechMultiContextRealtimeApplyTextNormalization, nil]
      # @param seed [Integer, nil]
      # @param enable_ssml_parsing [Elevenlabs::Internal::Types::Boolean, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [TextToSpeechMultiContextSocket] The connected socket; it is closed when the block returns.
      # @return [TextToSpeechMultiContextSocket, Object] The connected socket, or the block's value when a block is given.
      def realtime(voice_id:, authorization: nil, single_use_token: nil, model_id: nil, language_code: nil, enable_logging: nil, output_format: nil, inactivity_timeout: nil, sync_alignment: nil, auto_mode: nil, apply_text_normalization: nil, seed: nil, enable_ssml_parsing: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        TextToSpeechMultiContextSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: "/v1/text-to-speech/#{::URI.encode_uri_component(voice_id.to_s)}/multi-stream-input",
            query: { 'authorization' => authorization, 'single_use_token' => single_use_token, 'model_id' => model_id, 'language_code' => language_code, 'enable_logging' => enable_logging, 'output_format' => output_format, 'inactivity_timeout' => inactivity_timeout, 'sync_alignment' => sync_alignment, 'auto_mode' => auto_mode, 'apply_text_normalization' => apply_text_normalization, 'seed' => seed, 'enable_ssml_parsing' => enable_ssml_parsing },
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
