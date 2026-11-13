# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Procedures
      module Drafts
        class Client
          def initialize(client:)
            @client = client
          end

          # Get user's draft for a procedure
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/branches/#{URI.encode_uri_component(params[:branch_id].to_s)}/procedures/#{URI.encode_uri_component(params[:procedure_id].to_s)}/draft",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ProcedureDraftResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Create or update user's draft for a procedure
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request_body = ::Elevenlabs::Agents::Procedures::Drafts::Types::UpdateProcedureDraftRequestModel.new(params.except(:agent_id, :branch_id, :procedure_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PATCH',
              path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/branches/#{URI.encode_uri_component(params[:branch_id].to_s)}/procedures/#{URI.encode_uri_component(params[:procedure_id].to_s)}/draft",
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ProcedureDraftResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Delete user's draft for a procedure, resetting to the committed version
          def delete(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/branches/#{URI.encode_uri_component(params[:branch_id].to_s)}/procedures/#{URI.encode_uri_component(params[:procedure_id].to_s)}/draft",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::JSON.parse(body) }
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
