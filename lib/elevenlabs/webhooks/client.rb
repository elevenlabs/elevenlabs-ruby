# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Webhooks
    class Client
      def initialize(client:)
        @client = client
      end

      # List all webhooks for a workspace
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['include_usages'] = params[:include_usages] if params.key?(:include_usages)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/workspace/webhooks',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::WorkspaceWebhookListResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Create a new webhook for the workspace with the specified authentication type.
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Webhooks::Types::BodyCreateWorkspaceWebhookV1WorkspaceWebhooksPost.new(params)
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/workspace/webhooks',
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::WorkspaceCreateWebhookResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Update the specified workspace webhook
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Webhooks::Types::BodyUpdateWorkspaceWebhookV1WorkspaceWebhooksWebhookIDPatch.new(params.except(:webhook_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'PATCH',
          path: "v1/workspace/webhooks/#{URI.encode_uri_component(params[:webhook_id].to_s)}",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::PatchWorkspaceWebhookResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Delete the specified workspace webhook
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/workspace/webhooks/#{URI.encode_uri_component(params[:webhook_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DeleteWorkspaceWebhookResponseModel.load(body) }
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
