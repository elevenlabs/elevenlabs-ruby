# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Analytics
      module LiveCount
        class Client
          def initialize(client:)
            @client = client
          end

          # Get the live count of the ongoing conversations.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
            query_params['agent_ids'] = params[:agent_ids] if params.key?(:agent_ids)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/convai/analytics/live-count',
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetLiveCountResponse.load(body) }
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
