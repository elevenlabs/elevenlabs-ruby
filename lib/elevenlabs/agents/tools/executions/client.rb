# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Tools
      module Executions
        class Client
          def initialize(client:)
            @client = client
          end

          # Get paginated list of tool executions for a specific tool.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['is_error'] = params[:is_error] if params.key?(:is_error)
            query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
            query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
            query_params['start_time'] = params[:start_time] if params.key?(:start_time)
            query_params['end_time'] = params[:end_time] if params.key?(:end_time)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/tools/#{URI.encode_uri_component(params[:tool_id].to_s)}/executions",
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetToolExecutionsPageResponseModel.load(body) }
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
