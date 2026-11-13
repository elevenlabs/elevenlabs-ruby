# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Voices
    module Pvc
      module Verification
        class Client
          def initialize(client:)
            @client = client
          end

          # Request manual verification for a PVC voice.
          def request(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            body = ::Elevenlabs::Internal::Multipart::FormData.new
            params[:files]&.each { |item| body.add_file(name: 'files', file: item) }
            body.add(name: 'extra_text', value: params[:extra_text]) if params.key?(:extra_text)
            request = ::Elevenlabs::Internal::Multipart::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/verification",
              body: body,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::RequestPvcManualVerificationResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          def captcha
            @captcha ||= Captcha::Client.new(client: @client)
          end
        end
      end
    end
  end
end
