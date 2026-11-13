# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Messages
        class Client
          def initialize(client:)
            @client = client
          end

          # Search through conversation transcript messages by full-text and fuzzy search
          def text_search(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['text_query'] = params[:text_query] if params.key?(:text_query)
            query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
            query_params['visited_agent_ids'] = params[:visited_agent_ids] if params.key?(:visited_agent_ids)
            query_params['visited_agent_branch_ids'] = params[:visited_agent_branch_ids] if params.key?(:visited_agent_branch_ids)
            query_params['triggered_procedure_ids'] = params[:triggered_procedure_ids] if params.key?(:triggered_procedure_ids)
            query_params['call_successful'] = params[:call_successful] if params.key?(:call_successful)
            query_params['call_start_before_unix'] = params[:call_start_before_unix] if params.key?(:call_start_before_unix)
            query_params['call_start_after_unix'] = params[:call_start_after_unix] if params.key?(:call_start_after_unix)
            query_params['call_duration_min_secs'] = params[:call_duration_min_secs] if params.key?(:call_duration_min_secs)
            query_params['call_duration_max_secs'] = params[:call_duration_max_secs] if params.key?(:call_duration_max_secs)
            query_params['rating_max'] = params[:rating_max] if params.key?(:rating_max)
            query_params['rating_min'] = params[:rating_min] if params.key?(:rating_min)
            query_params['has_feedback_comment'] = params[:has_feedback_comment] if params.key?(:has_feedback_comment)
            query_params['user_id'] = params[:user_id] if params.key?(:user_id)
            query_params['evaluation_params'] = params[:evaluation_params] if params.key?(:evaluation_params)
            query_params['data_collection_params'] = params[:data_collection_params] if params.key?(:data_collection_params)
            query_params['dynamic_variable_params'] = params[:dynamic_variable_params] if params.key?(:dynamic_variable_params)
            query_params['tool_names'] = params[:tool_names] if params.key?(:tool_names)
            query_params['tool_names_successful'] = params[:tool_names_successful] if params.key?(:tool_names_successful)
            query_params['tool_names_errored'] = params[:tool_names_errored] if params.key?(:tool_names_errored)
            query_params['tool_ids'] = params[:tool_ids] if params.key?(:tool_ids)
            query_params['tool_ids_successful'] = params[:tool_ids_successful] if params.key?(:tool_ids_successful)
            query_params['tool_ids_errored'] = params[:tool_ids_errored] if params.key?(:tool_ids_errored)
            query_params['include_invalid_tool_calls'] = params[:include_invalid_tool_calls] if params.key?(:include_invalid_tool_calls)
            query_params['main_languages'] = params[:main_languages] if params.key?(:main_languages)
            query_params['phone_number_ids'] = params[:phone_number_ids] if params.key?(:phone_number_ids)
            query_params['whatsapp_phone_number_ids'] = params[:whatsapp_phone_number_ids] if params.key?(:whatsapp_phone_number_ids)
            query_params['exclude_statuses'] = params[:exclude_statuses] if params.key?(:exclude_statuses)
            query_params['termination_reasons'] = params[:termination_reasons] if params.key?(:termination_reasons)
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['summary_mode'] = params[:summary_mode] if params.key?(:summary_mode)
            query_params['conversation_initiation_source'] = params[:conversation_initiation_source] if params.key?(:conversation_initiation_source)
            query_params['text_only'] = params[:text_only] if params.key?(:text_only)
            query_params['conversation_product_type'] = params[:conversation_product_type] if params.key?(:conversation_product_type)
            query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
            query_params['version_id'] = params[:version_id] if params.key?(:version_id)
            query_params['topic_ids'] = params[:topic_ids] if params.key?(:topic_ids)
            query_params['sort_by'] = params[:sort_by] if params.key?(:sort_by)
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/convai/conversations/messages/text-search',
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::MessagesSearchResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Search conversation transcripts by semantic similarity to surface relevant messages based on meaning and intent, rather than exact keyword matches
          def search(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['text_query'] = params[:text_query] if params.key?(:text_query)
            query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
            query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/convai/conversations/messages/smart-search',
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::MessagesSearchResponse.load(body) }
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
