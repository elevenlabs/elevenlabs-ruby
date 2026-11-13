# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Environments
    class Client
      def initialize(client:)
        @client = client
      end

      # List the workspace environments, including 'production'.
      def list(request_options: {}, **params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/convai/environments',
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EnvironmentsListResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Create a workspace environment. Variables without a value for it fall back to their production value.
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Environments::Types::CreateEnvironmentRequest.new(params)
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/convai/environments',
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EnvironmentResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Delete a workspace environment and remove its values from all environment variables. 'production' cannot be deleted.
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/convai/environments/#{URI.encode_uri_component(params[:environment].to_s)}",
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
