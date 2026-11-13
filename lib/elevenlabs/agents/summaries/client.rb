# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Summaries
      class Client
        def initialize(client:)
          @client = client
        end

        # Returns summaries for the specified agents.
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['agent_ids'] = params[:agent_ids] if params.key?(:agent_ids)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/agents/summaries',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Summaries::Types::GetSummariesResponse].coerce(::JSON.parse(body, symbolize_names: false)) }
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
