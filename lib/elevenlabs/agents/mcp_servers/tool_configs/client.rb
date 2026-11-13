# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module McpServers
      module ToolConfigs
        class Client
          def initialize(client:)
            @client = client
          end

          # Create configuration overrides for a specific MCP tool.
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['environment'] = params[:environment] if params.key?(:environment)
            request_body = ::Elevenlabs::Agents::McpServers::ToolConfigs::Types::McpToolConfigOverrideCreateRequestModel.new(params.except(:mcp_server_id, :environment))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/convai/mcp-servers/#{URI.encode_uri_component(params[:mcp_server_id].to_s)}/tool-configs",
              query: query_params,
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::McpServerResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Retrieve configuration overrides for a specific MCP tool.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/mcp-servers/#{URI.encode_uri_component(params[:mcp_server_id].to_s)}/tool-configs/#{URI.encode_uri_component(params[:tool_name].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::McpToolConfigOverrideOutput.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Update configuration overrides for a specific MCP tool.
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['environment'] = params[:environment] if params.key?(:environment)
            request_body = ::Elevenlabs::Agents::McpServers::ToolConfigs::Types::McpToolConfigOverrideUpdateRequestModel.new(params.except(:mcp_server_id, :tool_name, :environment))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PATCH',
              path: "v1/convai/mcp-servers/#{URI.encode_uri_component(params[:mcp_server_id].to_s)}/tool-configs/#{URI.encode_uri_component(params[:tool_name].to_s)}",
              query: query_params,
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::McpServerResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Remove configuration overrides for a specific MCP tool.
          def delete(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/convai/mcp-servers/#{URI.encode_uri_component(params[:mcp_server_id].to_s)}/tool-configs/#{URI.encode_uri_component(params[:tool_name].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::McpServerResponseModel.load(body) }
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
