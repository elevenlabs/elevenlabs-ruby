# frozen_string_literal: true

module Elevenlabs
  module Agents
    module OutboundCampaigns
      module Config
        class Client
          def initialize(client:)
            @client = client
          end

          # Get the workspace's outbound campaign configuration: the default policy new campaigns take, and per-agent overrides.
          def get(request_options: {}, **params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/convai/outbound-campaigns/config',
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::WorkspaceConfigResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Create or replace the workspace's outbound campaign configuration. Send the `version` you last read as `expected_version`, or omit it to create the first configuration. A configuration changed since you read it is not replaced. Campaigns keep the policy they started with.
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request_body = ::Elevenlabs::Agents::OutboundCampaigns::Config::Types::ReplaceWorkspaceConfigRequest.new(params)
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PUT',
              path: 'v1/convai/outbound-campaigns/config',
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::WorkspaceConfigResponse.load(body) }
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
