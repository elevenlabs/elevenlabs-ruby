# frozen_string_literal: true

module Elevenlabs
  module Reception
    module BusinessProfile
      class Client
        def initialize(client:)
          @client = client
        end

        # Get the business profile the receptionists answer from, with the current time in the business's timezone.
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/reception/agent-info',
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionAgentInfoResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Update the business profile. Every receptionist is updated to match.
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request_body = ::Elevenlabs::Reception::BusinessProfile::Types::ReceptionUpdateAgentInfoRequest.new(params.except(:xi_workspace_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'PUT',
            path: 'v1/reception/agent-info',
            body: request_body.to_h.except('xi-workspace-id'),
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionAgentInfoResponse.load(body) }
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
