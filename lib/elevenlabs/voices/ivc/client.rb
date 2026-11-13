# frozen_string_literal: true

module Elevenlabs
  module Voices
    module Ivc
      class Client
        def initialize(client:)
          @client = client
        end

        # Create a voice clone and add it to your Voices
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          body = ::Elevenlabs::Internal::Multipart::FormData.new
          body.add(name: 'name', value: params[:name]) if params.key?(:name)
          params[:files]&.each { |item| body.add_file(name: 'files', file: item) }
          body.add(name: 'remove_background_noise', value: params[:remove_background_noise]) if params.key?(:remove_background_noise)
          body.add(name: 'description', value: params[:description]) if params.key?(:description)
          body.add(name: 'labels', value: params[:labels]) if params.key?(:labels)
          request = ::Elevenlabs::Internal::Multipart::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/voices/add',
            body: body,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AddVoiceIvcResponseModel.load(body) }
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
