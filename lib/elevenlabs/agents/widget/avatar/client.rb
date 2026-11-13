# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Widget
      module Avatar
        class Client
          def initialize(client:)
            @client = client
          end

          # Sets the avatar for an agent displayed in the widget
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            body = ::Elevenlabs::Internal::Multipart::FormData.new
            body.add_file(name: 'avatar_file', file: params[:avatar_file]) if params.key?(:avatar_file)
            request = ::Elevenlabs::Internal::Multipart::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/avatar",
              body: body,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::PostAgentAvatarResponseModel.load(body) }
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
