# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Drafts
      class Client
        def initialize(client:)
          @client = client
        end

        # Create a new draft for an agent
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
          request_body = ::Elevenlabs::Agents::Drafts::Types::BodyCreateAgentDraftV1ConvaiAgentsAgentIDDraftsPost.new(params.except(:agent_id, :branch_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/drafts",
            query: query_params,
            body: request_body.to_h,
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

        # Delete a draft for an agent
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/drafts",
            query: query_params,
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
