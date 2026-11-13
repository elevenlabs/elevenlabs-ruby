# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Voices
    module Pvc
      module Verification
        module Captcha
          class Client
            def initialize(client:)
              @client = client
            end

            # Get captcha for PVC voice verification.
            def get(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/captcha",
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              return if code.between?(200, 299)

              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end

            # Submit captcha verification for PVC voice.
            def verify(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              body = ::Elevenlabs::Internal::Multipart::FormData.new
              body.add_file(name: 'recording', file: params[:recording]) if params.key?(:recording)
              request = ::Elevenlabs::Internal::Multipart::Request.new(
                base_url: request_options[:base_url],
                method: 'POST',
                path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/captcha",
                body: body,
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::VerifyPvcVoiceCaptchaResponseModel.load(body) }
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
