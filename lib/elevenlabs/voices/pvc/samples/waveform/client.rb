# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Voices
    module Pvc
      module Samples
        module Waveform
          class Client
            def initialize(client:)
              @client = client
            end

            # Retrieve the visual waveform of a voice sample.
            def get(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/samples/#{URI.encode_uri_component(params[:sample_id].to_s)}/waveform",
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::VoiceSampleVisualWaveformResponseModel.load(body) }
                result.validate! if result.respond_to?(:validate!)
                result
              else
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
end
