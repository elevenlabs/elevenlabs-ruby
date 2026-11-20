# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Reception
    module Receptionists
      module TransferRules
        class Client
          def initialize(client:)
            @client = client
          end

          # Add a phone forwarding rule to the named receptionist.
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Receptionists::TransferRules::Types::ReceptionCreateTransferRuleRequest.new(params.except(:agent_id, :xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/reception/customer-facing-agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/transfer-rules",
              body: request_body.to_h,
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionTransferRule.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Replace an existing transfer rule on the named receptionist. Send every field: an omitted `post_dial_digits` clears it.
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Receptionists::TransferRules::Types::ReceptionUpdateTransferRuleRequest.new(params.except(:agent_id, :rule_id, :xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PUT',
              path: "v1/reception/customer-facing-agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/transfer-rules/#{URI.encode_uri_component(params[:rule_id].to_s)}",
              body: request_body.to_h,
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionTransferRule.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Delete a transfer rule from the named receptionist.
          def delete(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/reception/customer-facing-agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/transfer-rules/#{URI.encode_uri_component(params[:rule_id].to_s)}",
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Hash[String, String].coerce(::JSON.parse(body, symbolize_names: false)) }
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
