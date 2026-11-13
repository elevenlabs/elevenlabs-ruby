# frozen_string_literal: true

module Elevenlabs
  module SpeechToText
    class Client
      def initialize(client:)
        @client = client
      end

      # Transcribe an audio or video file. If webhook is set to true, the request will be processed asynchronously and results sent to configured webhooks. When use_multi_channel is true and the provided audio has multiple channels, a 'transcripts' object with separate transcripts for each channel is returned; set multichannel_output_style='combined' to instead receive a single transcript with all channels merged and sorted by time. Otherwise, returns a single transcript. The optional webhook_metadata parameter allows you to attach custom data that will be included in webhook responses for request correlation and tracking.
      def convert(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['token'] = params[:token] if params.key?(:token)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add(name: 'model_id', value: params[:model_id]) if params.key?(:model_id)
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add(name: 'language_code', value: params[:language_code]) if params.key?(:language_code)
        params[:secondary_language_codes]&.each { |item| body.add(name: 'secondary_language_codes', value: item) }
        body.add(name: 'numbers_format', value: params[:numbers_format]) if params.key?(:numbers_format)
        body.add(name: 'transcript_edit', value: params[:transcript_edit]) if params.key?(:transcript_edit)
        body.add(name: 'tag_audio_events', value: params[:tag_audio_events]) if params.key?(:tag_audio_events)
        body.add(name: 'num_speakers', value: params[:num_speakers]) if params.key?(:num_speakers)
        body.add(name: 'timestamps_granularity', value: params[:timestamps_granularity]) if params.key?(:timestamps_granularity)
        body.add(name: 'diarize', value: params[:diarize]) if params.key?(:diarize)
        body.add(name: 'diarization_threshold', value: params[:diarization_threshold]) if params.key?(:diarization_threshold)
        params[:additional_formats]&.each { |item| body.add(name: 'additional_formats', value: item, content_type: 'application/json') }
        body.add(name: 'file_format', value: params[:file_format]) if params.key?(:file_format)
        body.add(name: 'source_url', value: params[:source_url]) if params.key?(:source_url)
        body.add(name: 'webhook', value: params[:webhook]) if params.key?(:webhook)
        body.add(name: 'webhook_id', value: params[:webhook_id]) if params.key?(:webhook_id)
        body.add(name: 'temperature', value: params[:temperature]) if params.key?(:temperature)
        body.add(name: 'seed', value: params[:seed]) if params.key?(:seed)
        body.add(name: 'use_multi_channel', value: params[:use_multi_channel]) if params.key?(:use_multi_channel)
        body.add(name: 'multichannel_output_style', value: params[:multichannel_output_style]) if params.key?(:multichannel_output_style)
        body.add(name: 'webhook_metadata', value: params[:webhook_metadata]) if params.key?(:webhook_metadata)
        body.add(name: 'entity_detection', value: params[:entity_detection]) if params.key?(:entity_detection)
        body.add(name: 'no_verbatim', value: params[:no_verbatim]) if params.key?(:no_verbatim)
        body.add(name: 'use_speaker_library', value: params[:use_speaker_library]) if params.key?(:use_speaker_library)
        body.add(name: 'detect_speaker_roles', value: params[:detect_speaker_roles]) if params.key?(:detect_speaker_roles)
        body.add(name: 'entity_redaction', value: params[:entity_redaction]) if params.key?(:entity_redaction)
        body.add(name: 'entity_redaction_mode', value: params[:entity_redaction_mode]) if params.key?(:entity_redaction_mode)
        params[:keyterms]&.each { |item| body.add(name: 'keyterms', value: item) }
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/speech-to-text',
          query: query_params,
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        unless code.between?(200, 299)
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
        case code
        when 202
          ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::JSON.parse(body) }
        else
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::SpeechToText::Types::ConvertSpeechToTextResponse.load!(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        end
      end

      # Opens a WebSocket connection to the `speech_to_text` channel.
      #
      # @param model_id [Elevenlabs::V1SpeechToTextRealtime::Types::SpeechToTextRealtimeModelID]
      # @param token [String, nil]
      # @param audio_format [String, nil]
      # @param language_code [String, nil]
      # @param secondary_languages [Elevenlabs::Internal::Types::Array[String], nil]
      # @param commit_strategy [Elevenlabs::V1SpeechToTextRealtime::Types::SpeechToTextRealtimeCommitStrategy, nil]
      # @param vad_threshold [Float, nil]
      # @param vad_silence_threshold_secs [Float, nil]
      # @param min_speech_duration_ms [Integer, nil]
      # @param min_silence_duration_ms [Integer, nil]
      # @param include_timestamps [Elevenlabs::Internal::Types::Boolean, nil]
      # @param include_language_detection [Elevenlabs::Internal::Types::Boolean, nil]
      # @param keyterms [Elevenlabs::Internal::Types::Array[String], nil]
      # @param no_verbatim [Elevenlabs::Internal::Types::Boolean, nil]
      # @param multilang_mode [Elevenlabs::Internal::Types::Boolean, nil]
      # @param diarize [Elevenlabs::Internal::Types::Boolean, nil]
      # @param entity_detection [Elevenlabs::V1SpeechToTextRealtime::Types::V1SpeechToTextRealtimeV1SpeechToTextRealtimeRequestEntityDetection, nil]
      # @param entity_redaction [Elevenlabs::V1SpeechToTextRealtime::Types::V1SpeechToTextRealtimeV1SpeechToTextRealtimeRequestEntityRedaction, nil]
      # @param entity_redaction_mode [Elevenlabs::V1SpeechToTextRealtime::Types::SpeechToTextRealtimeEntityRedactionMode, nil]
      # @param transcript_edit [String, nil]
      # @param filter_background_audio [Elevenlabs::Internal::Types::Boolean, nil]
      # @param keepalive_interval_ms [Integer, nil]
      # @param enable_logging [Elevenlabs::Internal::Types::Boolean, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [SpeechToTextSocket] The connected socket; it is closed when the block returns.
      # @return [SpeechToTextSocket, Object] The connected socket, or the block's value when a block is given.
      def realtime(model_id:, token: nil, audio_format: nil, language_code: nil, secondary_languages: nil, commit_strategy: nil, vad_threshold: nil, vad_silence_threshold_secs: nil, min_speech_duration_ms: nil, min_silence_duration_ms: nil, include_timestamps: nil, include_language_detection: nil, keyterms: nil, no_verbatim: nil, multilang_mode: nil, diarize: nil, entity_detection: nil, entity_redaction: nil, entity_redaction_mode: nil, transcript_edit: nil, filter_background_audio: nil, keepalive_interval_ms: nil, enable_logging: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        SpeechToTextSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: '/v1/speech-to-text/realtime',
            query: { 'model_id' => model_id, 'token' => token, 'audio_format' => audio_format, 'language_code' => language_code, 'secondary_languages' => secondary_languages, 'commit_strategy' => commit_strategy, 'vad_threshold' => vad_threshold, 'vad_silence_threshold_secs' => vad_silence_threshold_secs, 'min_speech_duration_ms' => min_speech_duration_ms, 'min_silence_duration_ms' => min_silence_duration_ms, 'include_timestamps' => include_timestamps, 'include_language_detection' => include_language_detection, 'keyterms' => keyterms, 'no_verbatim' => no_verbatim, 'multilang_mode' => multilang_mode, 'diarize' => diarize, 'entity_detection' => entity_detection, 'entity_redaction' => entity_redaction, 'entity_redaction_mode' => entity_redaction_mode, 'transcript_edit' => transcript_edit, 'filter_background_audio' => filter_background_audio, 'keepalive_interval_ms' => keepalive_interval_ms, 'enable_logging' => enable_logging },
            client_query: @client.websocket_query,
            request_options: request_options,
          ),
          headers: -> { ::Elevenlabs::Internal::WebSocket::Handshake.headers(client_headers: @client.websocket_headers, credentials: -> { @client.websocket_credentials }, request_options: request_options) },
          reconnect: reconnect,
          connect_timeout: connect_timeout,
          &block
        )
      end

      def transcripts
        @transcripts ||= Transcripts::Client.new(client: @client)
      end
    end
  end
end
