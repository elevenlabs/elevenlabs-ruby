# frozen_string_literal: true

module Elevenlabs
  module TextToSoundEffects
    class Client
      def initialize(client:)
        @client = client
      end

      # Turn text into sound effects for your videos, voice-overs or video games using the most advanced sound effects models in the world.
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
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        request_body = ::Elevenlabs::TextToSoundEffects::Types::CreateSoundEffectRequest.new(params.except(:output_format, :enable_logging))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/sound-generation',
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
    end
  end
end
