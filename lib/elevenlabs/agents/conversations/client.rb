# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Conversations
      class Client
        def initialize(client:)
          @client = client
        end

        # Get a signed url to start a conversation with an agent with an agent that requires authorization
        def get_signed_url(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
          query_params['include_conversation_id'] = params[:include_conversation_id] if params.key?(:include_conversation_id)
          query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
          query_params['version_id'] = params[:version_id] if params.key?(:version_id)
          query_params['environment'] = params[:environment] if params.key?(:environment)
          query_params['debug_events_request'] = params[:debug_events_request] if params.key?(:debug_events_request)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/conversation/get-signed-url',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ConversationSignedURLResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get a WebRTC session token for real-time communication.
        def get_webrtc_token(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
          query_params['participant_name'] = params[:participant_name] if params.key?(:participant_name)
          query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
          query_params['version_id'] = params[:version_id] if params.key?(:version_id)
          query_params['environment'] = params[:environment] if params.key?(:environment)
          query_params['debug_events_request'] = params[:debug_events_request] if params.key?(:debug_events_request)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/conversation/token',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::TokenResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get all conversations of agents that user owns. With option to restrict to a specific agent.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
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
          query_params['data_collection_filter'] = params[:data_collection_filter] if params.key?(:data_collection_filter)
          query_params['dynamic_variable_filter'] = params[:dynamic_variable_filter] if params.key?(:dynamic_variable_filter)
          query_params['data_collection_ids'] = params[:data_collection_ids] if params.key?(:data_collection_ids)
          query_params['evaluation_criteria_ids'] = params[:evaluation_criteria_ids] if params.key?(:evaluation_criteria_ids)
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
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['summary_mode'] = params[:summary_mode] if params.key?(:summary_mode)
          query_params['search'] = params[:search] if params.key?(:search)
          query_params['conversation_initiation_source'] = params[:conversation_initiation_source] if params.key?(:conversation_initiation_source)
          query_params['text_only'] = params[:text_only] if params.key?(:text_only)
          query_params['conversation_product_type'] = params[:conversation_product_type] if params.key?(:conversation_product_type)
          query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
          query_params['version_id'] = params[:version_id] if params.key?(:version_id)
          query_params['parent_conversation_id'] = params[:parent_conversation_id] if params.key?(:parent_conversation_id)
          query_params['topic_ids'] = params[:topic_ids] if params.key?(:topic_ids)
          query_params['exclude_statuses'] = params[:exclude_statuses] if params.key?(:exclude_statuses)
          query_params['tag_ids'] = params[:tag_ids] if params.key?(:tag_ids)
          query_params['workflow_node_entered_id'] = params[:workflow_node_entered_id] if params.key?(:workflow_node_entered_id)
          query_params['termination_reasons'] = params[:termination_reasons] if params.key?(:termination_reasons)
          query_params['guardrail_types'] = params[:guardrail_types] if params.key?(:guardrail_types)
          query_params['custom_guardrail_names'] = params[:custom_guardrail_names] if params.key?(:custom_guardrail_names)
          query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/conversations',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetConversationsPageResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Resolve a conversation URL (a Slack message URL or a Zendesk ticket URL) to the deterministic conversation ID for the given agent, then confirm the conversation exists.
        def resolve(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
          query_params['reference'] = params[:reference] if params.key?(:reference)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/conversations/resolve',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetConversationResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get the details of a particular conversation
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['format'] = params[:format] if params.key?(:format)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}",
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetConversationResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Delete a particular conversation
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}",
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

        # Get a lightweight summary of a conversation: its title, the generated transcript summary, whether the call was successful, and — only when the conversation is short — the plain chat messages. Tool calls, tool results, and contextual updates are omitted so the response stays small. Use this instead of the full conversation endpoint when you only need the gist (e.g. an agent reading many conversations); use GET /v1/convai/conversations/{conversation_id} when you need the full transcript with tool calls and contextual updates.
        def get_summary(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['max_messages'] = params[:max_messages] if params.key?(:max_messages)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}/summary",
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetConversationSummaryResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get SIP messages associated with a conversation's phone call
        def get_sip_messages(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}/sip-messages",
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetSipLogMessagesResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        def audio
          @audio ||= Audio::Client.new(client: @client)
        end

        def files
          @files ||= Files::Client.new(client: @client)
        end

        def feedback
          @feedback ||= Feedback::Client.new(client: @client)
        end

        def messages
          @messages ||= Messages::Client.new(client: @client)
        end

        def tags
          @tags ||= Tags::Client.new(client: @client)
        end

        def topics
          @topics ||= Topics::Client.new(client: @client)
        end

        def analysis
          @analysis ||= Analysis::Client.new(client: @client)
        end
      end
    end
  end
end
