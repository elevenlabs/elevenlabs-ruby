# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module AudioIsolation
    class Client
      def initialize(client:)
        @client = client
      end

      # Removes background noise from audio.
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
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'audio', file: params[:audio]) if params.key?(:audio)
        body.add(name: 'file_format', value: params[:file_format]) if params.key?(:file_format)
        body.add(name: 'preview_b64', value: params[:preview_b64]) if params.key?(:preview_b64)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/audio-isolation',
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

      # Returns a list of all your audio isolation generations.
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['page'] = params[:page] if params.key?(:page)
        query_params['search'] = params[:search] if params.key?(:search)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/audio-isolation/history',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAudioIsolationHistoryResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Deletes a specific audio isolation history item and the associated media files.
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/audio-isolation/history/#{URI.encode_uri_component(params[:history_item_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        return if code.between?(200, 299)

        error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
        error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
        raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
      end

      # Removes background noise from audio.
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
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'audio', file: params[:audio]) if params.key?(:audio)
        body.add(name: 'file_format', value: params[:file_format]) if params.key?(:file_format)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/audio-isolation/stream',
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
