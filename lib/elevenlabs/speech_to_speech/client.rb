# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module SpeechToSpeech
    class Client
      def initialize(client:)
        @client = client
      end

      # Transform audio from one voice to another. Maintain full control over emotion, timing and delivery.
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
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'audio', file: params[:audio]) if params.key?(:audio)
        body.add(name: 'model_id', value: params[:model_id]) if params.key?(:model_id)
        body.add(name: 'voice_settings', value: params[:voice_settings]) if params.key?(:voice_settings)
        body.add(name: 'seed', value: params[:seed]) if params.key?(:seed)
        body.add(name: 'remove_background_noise', value: params[:remove_background_noise]) if params.key?(:remove_background_noise)
        body.add(name: 'file_format', value: params[:file_format]) if params.key?(:file_format)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/voice-changer/#{URI.encode_uri_component(params[:voice_id].to_s)}",
          query: query_params,
          body: body,
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Stream audio from one voice to another. Maintain full control over emotion, timing and delivery.
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
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'audio', file: params[:audio]) if params.key?(:audio)
        body.add(name: 'model_id', value: params[:model_id]) if params.key?(:model_id)
        body.add(name: 'voice_settings', value: params[:voice_settings]) if params.key?(:voice_settings)
        body.add(name: 'seed', value: params[:seed]) if params.key?(:seed)
        body.add(name: 'remove_background_noise', value: params[:remove_background_noise]) if params.key?(:remove_background_noise)
        body.add(name: 'file_format', value: params[:file_format]) if params.key?(:file_format)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/voice-changer/#{URI.encode_uri_component(params[:voice_id].to_s)}/stream",
          query: query_params,
          body: body,
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end
    end
  end
end
