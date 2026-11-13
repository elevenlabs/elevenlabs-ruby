# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Studio
    module Projects
      module Content
        class Client
          def initialize(client:)
            @client = client
          end

          # Updates Studio project content.
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            body = ::Elevenlabs::Internal::Multipart::FormData.new
            body.add(name: 'from_url', value: params[:from_url]) if params.key?(:from_url)
            body.add_file(name: 'from_document', file: params[:from_document]) if params.key?(:from_document)
            body.add(name: 'from_content_json', value: params[:from_content_json]) if params.key?(:from_content_json)
            body.add(name: 'auto_convert', value: params[:auto_convert]) if params.key?(:auto_convert)
            request = ::Elevenlabs::Internal::Multipart::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}/content",
              body: body,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EditProjectResponseModel.load(body) }
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
