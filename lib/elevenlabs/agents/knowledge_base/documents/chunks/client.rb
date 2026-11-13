# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Chunks
          class Client
            def initialize(client:)
              @client = client
            end

            # Get all RAG chunks for a specific knowledge base document.
            def list(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              query_params = {}
              query_params['embedding_model'] = params[:embedding_model] if params.key?(:embedding_model)
              query_params['page_size'] = params[:page_size] if params.key?(:page_size)
              query_params['cursor'] = params[:cursor] if params.key?(:cursor)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: "v1/convai/knowledge-base/#{URI.encode_uri_component(params[:documentation_id].to_s)}/chunks",
                query: query_params,
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::KnowledgeBaseDocumentChunksResponseModel.load(body) }
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
end
