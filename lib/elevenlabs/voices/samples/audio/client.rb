# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Voices
    module Samples
      module Audio
        class Client
          def initialize(client:)
            @client = client
          end

          # Returns the audio corresponding to a sample attached to a voice.
          #
          # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
          # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
          # start before the server has finished. `read` on the Enumerator returns the whole body as one
          # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
          # from this call.
          #
          # @return [Enumerator]
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/voices/#{URI.encode_uri_component(params[:voice_id].to_s)}/samples/#{URI.encode_uri_component(params[:sample_id].to_s)}/audio",
              accept: 'audio/*',
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
  end
end
