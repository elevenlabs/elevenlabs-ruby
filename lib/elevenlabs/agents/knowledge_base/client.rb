# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module KnowledgeBase
      class Client
        def initialize(client:)
          @client = client
        end

        # Returns the number of pages in the agent's knowledge base.
        def size(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/convai/agent/#{URI.encode_uri_component(params[:agent_id].to_s)}/knowledge-base/size",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAgentKnowledgebaseSizeResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get a list of available knowledge base documents
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['search'] = params[:search] if params.key?(:search)
          query_params['show_only_owned_documents'] = params[:show_only_owned_documents] if params.key?(:show_only_owned_documents)
          query_params['created_by_user_id'] = params[:created_by_user_id] if params.key?(:created_by_user_id)
          query_params['types'] = params[:types] if params.key?(:types)
          query_params['parent_folder_id'] = params[:parent_folder_id] if params.key?(:parent_folder_id)
          query_params['ancestor_folder_id'] = params[:ancestor_folder_id] if params.key?(:ancestor_folder_id)
          query_params['folders_first'] = params[:folders_first] if params.key?(:folders_first)
          query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
          query_params['sort_by'] = params[:sort_by] if params.key?(:sort_by)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/knowledge-base',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetKnowledgeBaseListResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Retrieves and/or creates RAG indexes for multiple knowledge base documents in a single request. Maximum 100 items per request.
        def get_or_create_rag_indexes(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::KnowledgeBase::Types::BodyComputeRagIndexesInBatchV1ConvaiKnowledgeBaseRagIndexPost.new(params)
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/convai/knowledge-base/rag-index',
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::KnowledgeBase::Types::GetOrCreateRagIndexesKnowledgeBaseResponse].coerce(::JSON.parse(body, symbolize_names: false)) }
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Fuzzy text search over knowledge base document content
        def search(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['query'] = params[:query] if params.key?(:query)
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['types'] = params[:types] if params.key?(:types)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/knowledge-base/search',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::KnowledgeBaseContentSearchResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        def documents
          @documents ||= Documents::Client.new(client: @client)
        end

        def crawl_jobs
          @crawl_jobs ||= CrawlJobs::Client.new(client: @client)
        end

        def document
          @document ||= Document::Client.new(client: @client)
        end
      end
    end
  end
end
