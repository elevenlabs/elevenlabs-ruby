# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Conversations
      module Topics
        class Client
          def initialize(client:)
            @client = client
          end

          # Returns the latest topic discovery run results for a given agent.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['sort_by'] = params[:sort_by] if params.key?(:sort_by)
            query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
            query_params['from_unix_secs'] = params[:from_unix_secs] if params.key?(:from_unix_secs)
            query_params['to_unix_secs'] = params[:to_unix_secs] if params.key?(:to_unix_secs)
            query_params['include_evaluation_criteria'] = params[:include_evaluation_criteria] if params.key?(:include_evaluation_criteria)
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/topics",
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAgentTopicsResponseModel.load(body) }
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
