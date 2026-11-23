# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Reception
    module Receptionists
      class Client
        def initialize(client:, base_url: nil, environment: nil)
          @client = client
          @base_url = base_url
          @environment = environment
        end

        # List every customer-facing receptionist for the workspace.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/reception/customer-facing-agents',
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionCustomerFacingAgentResponse].coerce(::JSON.parse(body, symbolize_names: false)) }
            result&.each { |item| item.validate! if item.respond_to?(:validate!) }
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Update a receptionist's display name, config and/or widget appearance.
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request_body = ::Elevenlabs::Reception::Receptionists::Types::ReceptionUpdateCustomerFacingAgentRequest.new(params.except(:agent_id, :xi_workspace_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'PATCH',
            path: "v1/reception/customer-facing-agents/#{URI.encode_uri_component(params[:agent_id].to_s)}",
            body: request_body.to_h,
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionCustomerFacingAgentResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Re-activate a deactivated receptionist. Fails with `quota_exceeded` when the plan has no free receptionist slot.
        def activate(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/reception/customer-facing-agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/activate",
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionCustomerFacingAgentResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        def rules
          @rules ||= Rules::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end

        def procedures
          @procedures ||= Procedures::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end

        def transfer_rules
          @transfer_rules ||= TransferRules::Client.new(client: @client, base_url: @base_url, environment: @environment)
        end
      end
    end
  end
end
