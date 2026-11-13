# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module EnvironmentVariables
    class Client
      def initialize(client:)
        @client = client
      end

      # List all environment variables for the workspace with optional filtering
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['cursor'] = params[:cursor] if params.key?(:cursor)
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['label'] = params[:label] if params.key?(:label)
        query_params['environment'] = params[:environment] if params.key?(:environment)
        query_params['type'] = params[:type] if params.key?(:type)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/convai/environment-variables',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EnvironmentVariablesListResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Create a new environment variable for the workspace
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/convai/environment-variables',
          body: ::Elevenlabs::EnvironmentVariables::Types::CreateEnvironmentVariablesRequest.coerce(params).then { |c| !c.nil? && !c.is_a?(::Array) && c.respond_to?(:to_h) ? c.to_h : c },
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EnvironmentVariableResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Get a specific environment variable by ID
      def get(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/convai/environment-variables/#{URI.encode_uri_component(params[:env_var_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EnvironmentVariableResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Replace an environment variable's values. Use null to remove its value for an environment (except production); delete an environment with DELETE /v1/convai/environments/{environment}.
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::EnvironmentVariables::Types::UpdateEnvironmentVariableRequest.new(params.except(:env_var_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'PATCH',
          path: "v1/convai/environment-variables/#{URI.encode_uri_component(params[:env_var_id].to_s)}",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EnvironmentVariableResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Delete an environment variable and its values in all environments. WARNING: Agents are not checked. A variable that an agent still uses (custom LLM, webhooks or cloud storage export, on any branch or version) is deleted anyway, and that agent's conversations then fail. The delete is only rejected while tools, MCP servers or the workspace conversation initiation webhook use the variable.
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/convai/environment-variables/#{URI.encode_uri_component(params[:env_var_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        return if code.between?(200, 299)

        error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
        error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
        raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
      end
    end
  end
end
