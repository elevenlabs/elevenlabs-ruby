# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Summaries
          class Client
            def initialize(client:)
              @client = client
            end

            # Gets multiple knowledge base document summaries by their IDs.
            def get(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              query_params = {}
              query_params['document_ids'] = params[:document_ids] if params.key?(:document_ids)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: 'v1/convai/knowledge-base/summaries',
                query: query_params,
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Summaries::Types::GetSummariesResponse2].coerce(::JSON.parse(body, symbolize_names: false)) }
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
end
