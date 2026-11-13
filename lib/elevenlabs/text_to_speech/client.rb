# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module TextToSpeech
    class Client
      def initialize(client:)
        @client = client
      end

      # Converts text into speech using a voice of your choice and returns audio.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def convert(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        query_params['optimize_streaming_latency'] = params[:optimize_streaming_latency] if params.key?(:optimize_streaming_latency)
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        request_body = ::Elevenlabs::TextToSpeech::Types::BodyTextToSpeechFull.new(params.except(:voice_id, :enable_logging, :optimize_streaming_latency, :output_format))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/text-to-speech/#{URI.encode_uri_component(params[:voice_id].to_s)}",
          query: query_params,
          body: request_body.to_h,
          accept: 'audio/mpeg',
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Generate speech from text with precise character-level timing information for audio-text synchronization.
      def convert_with_timestamps(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        query_params['optimize_streaming_latency'] = params[:optimize_streaming_latency] if params.key?(:optimize_streaming_latency)
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        request_body = ::Elevenlabs::TextToSpeech::Types::BodyTextToSpeechFullWithTimestamps.new(params.except(:voice_id, :enable_logging, :optimize_streaming_latency, :output_format))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/text-to-speech/#{URI.encode_uri_component(params[:voice_id].to_s)}/with-timestamps",
          query: query_params,
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AudioWithTimestampsResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Converts text into speech using a voice of your choice and returns audio as an audio stream.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def stream(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        query_params['optimize_streaming_latency'] = params[:optimize_streaming_latency] if params.key?(:optimize_streaming_latency)
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        request_body = ::Elevenlabs::TextToSpeech::Types::BodyTextToSpeechStream.new(params.except(:voice_id, :enable_logging, :optimize_streaming_latency, :output_format))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/text-to-speech/#{URI.encode_uri_component(params[:voice_id].to_s)}/stream",
          query: query_params,
          body: request_body.to_h,
          accept: 'audio/mpeg',
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Converts text into speech using a voice of your choice and returns a stream of JSONs containing audio as a base64 encoded string together with information on when which character was spoken.
      def stream_with_timestamps(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        query_params['optimize_streaming_latency'] = params[:optimize_streaming_latency] if params.key?(:optimize_streaming_latency)
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        request_body = ::Elevenlabs::TextToSpeech::Types::BodyTextToSpeechStreamWithTimestamps.new(params.except(:voice_id, :enable_logging, :optimize_streaming_latency, :output_format))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/text-to-speech/#{URI.encode_uri_component(params[:voice_id].to_s)}/stream/with-timestamps",
          query: query_params,
          body: request_body.to_h,
          request_options: request_options,
        )
        chunks = ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
        ::Elevenlabs::Internal::Http::JsonStream.decode(chunks) do |message|
          result = ::Elevenlabs::Types::StreamingAudioChunkWithTimestampsResponse.load(message)
          result.validate! if result.respond_to?(:validate!)
          result
        end
      end

      # Opens a WebSocket connection to the `text_to_speech` channel.
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
      # @param apply_text_normalization [Elevenlabs::V1TextToSpeechVoiceIDStreamInput::Types::TextToSpeechRealtimeApplyTextNormalization, nil]
      # @param seed [Integer, nil]
      # @param enable_ssml_parsing [Elevenlabs::Internal::Types::Boolean, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [TextToSpeechSocket] The connected socket; it is closed when the block returns.
      # @return [TextToSpeechSocket, Object] The connected socket, or the block's value when a block is given.
      def realtime(voice_id:, authorization: nil, single_use_token: nil, model_id: nil, language_code: nil, enable_logging: nil, output_format: nil, inactivity_timeout: nil, sync_alignment: nil, auto_mode: nil, apply_text_normalization: nil, seed: nil, enable_ssml_parsing: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        TextToSpeechSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: "/v1/text-to-speech/#{::URI.encode_uri_component(voice_id.to_s)}/stream-input",
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
