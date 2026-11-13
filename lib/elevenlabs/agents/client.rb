# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    class Client
      def initialize(client:)
        @client = client
      end

      # Create an agent from a config object
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['enable_versioning'] = params[:enable_versioning] if params.key?(:enable_versioning)
        request_body = ::Elevenlabs::Agents::Types::BodyCreateAgentV1ConvaiAgentsCreatePost.new(params.except(:enable_versioning))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/convai/agents/create',
          query: query_params,
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::CreateAgentResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Retrieve config for an agent
      def get(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['version_id'] = params[:version_id] if params.key?(:version_id)
        query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
        query_params['include_procedure_generated_workflow_elements'] = params[:include_procedure_generated_workflow_elements] if params.key?(:include_procedure_generated_workflow_elements)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}",
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAgentResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Patches an Agent settings
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['enable_versioning_if_not_enabled'] = params[:enable_versioning_if_not_enabled] if params.key?(:enable_versioning_if_not_enabled)
        query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
        query_params['include_procedure_generated_workflow_elements'] = params[:include_procedure_generated_workflow_elements] if params.key?(:include_procedure_generated_workflow_elements)
        request_body = ::Elevenlabs::Agents::Types::UpdateAgentRequest.new(params.except(:agent_id, :enable_versioning_if_not_enabled, :branch_id, :include_procedure_generated_workflow_elements))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'PATCH',
          path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}",
          query: query_params,
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAgentResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Delete an agent
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['force'] = params[:force] if params.key?(:force)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}",
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        unless code.between?(200, 299)
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
        case code
        when 204
          nil
        end
      end

      # Returns a list of your agents and their metadata.
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['search'] = params[:search] if params.key?(:search)
        query_params['archived'] = params[:archived] if params.key?(:archived)
        query_params['show_only_owned_agents'] = params[:show_only_owned_agents] if params.key?(:show_only_owned_agents)
        query_params['created_by_user_id'] = params[:created_by_user_id] if params.key?(:created_by_user_id)
        query_params['tags'] = params[:tags] if params.key?(:tags)
        query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
        query_params['sort_by'] = params[:sort_by] if params.key?(:sort_by)
        query_params['cursor'] = params[:cursor] if params.key?(:cursor)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/convai/agents',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAgentsPageResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Create a new agent by duplicating an existing one. The new agent gets a copy of every unarchived branch of the source agent, each with the same name and description and starting from the latest version on that branch. The live traffic split is copied onto the new branches, with any share held by a branch that was not copied moved to main. Version history, drafts, archived branches, past traffic splits and experiments are not copied.
      def duplicate(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Agents::Types::BodyDuplicateAgentV1ConvaiAgentsAgentIDDuplicatePost.new(params.except(:agent_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/duplicate",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::CreateAgentResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Run selected tests on the agent with provided configuration. If the agent configuration is provided, it will be used to override default agent configuration.
      def run_tests(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Agents::Types::RunAgentTestsRequestModel.new(params.except(:agent_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/run-tests",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetTestSuiteInvocationResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Provides total size and other information of RAG indexes used by knowledgebase documents
      def rag_index_overview(request_options: {}, **params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/convai/knowledge-base/rag-index',
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::RagIndexOverviewResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Provides information about all RAG indexes of the specified knowledgebase document.
      def get_document_rag_indexes(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/convai/knowledge-base/#{URI.encode_uri_component(params[:documentation_id].to_s)}/rag-index",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::RagDocumentIndexesResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Delete RAG index for the knowledgebase document.
      def delete_document_rag_index(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/convai/knowledge-base/#{URI.encode_uri_component(params[:documentation_id].to_s)}/rag-index/#{URI.encode_uri_component(params[:rag_index_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::RagDocumentIndexResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      def conversations
        @conversations ||= Conversations::Client.new(client: @client)
      end

      def twilio
        @twilio ||= Twilio::Client.new(client: @client)
      end

      def exotel
        @exotel ||= Exotel::Client.new(client: @client)
      end

      def whatsapp
        @whatsapp ||= Whatsapp::Client.new(client: @client)
      end

      def summaries
        @summaries ||= Summaries::Client.new(client: @client)
      end

      def widget
        @widget ||= Widget::Client.new(client: @client)
      end

      def link
        @link ||= Link::Client.new(client: @client)
      end

      def hold_audio
        @hold_audio ||= HoldAudio::Client.new(client: @client)
      end

      def knowledge_base
        @knowledge_base ||= KnowledgeBase::Client.new(client: @client)
      end

      def llm_usage
        @llm_usage ||= LlmUsage::Client.new(client: @client)
      end

      def tests
        @tests ||= Tests::Client.new(client: @client)
      end

      def users
        @users ||= Users::Client.new(client: @client)
      end

      def triage_tickets
        @triage_tickets ||= TriageTickets::Client.new(client: @client)
      end

      def phone_numbers
        @phone_numbers ||= PhoneNumbers::Client.new(client: @client)
      end

      def llm
        @llm ||= Llm::Client.new(client: @client)
      end

      def analytics
        @analytics ||= Analytics::Client.new(client: @client)
      end

      def tools
        @tools ||= Tools::Client.new(client: @client)
      end

      def analysis_items
        @analysis_items ||= AnalysisItems::Client.new(client: @client)
      end

      def settings
        @settings ||= Settings::Client.new(client: @client)
      end

      def dashboard
        @dashboard ||= Dashboard::Client.new(client: @client)
      end

      def secrets
        @secrets ||= Secrets::Client.new(client: @client)
      end

      def batch_calls
        @batch_calls ||= BatchCalls::Client.new(client: @client)
      end

      def sip_trunk
        @sip_trunk ||= SipTrunk::Client.new(client: @client)
      end

      def mcp_servers
        @mcp_servers ||= McpServers::Client.new(client: @client)
      end

      def whatsapp_accounts
        @whatsapp_accounts ||= WhatsappAccounts::Client.new(client: @client)
      end

      def branches
        @branches ||= Branches::Client.new(client: @client)
      end

      def versions
        @versions ||= Versions::Client.new(client: @client)
      end

      def deployments
        @deployments ||= Deployments::Client.new(client: @client)
      end

      def drafts
        @drafts ||= Drafts::Client.new(client: @client)
      end

      def merge_proposals
        @merge_proposals ||= MergeProposals::Client.new(client: @client)
      end

      def outbound_campaigns
        @outbound_campaigns ||= OutboundCampaigns::Client.new(client: @client)
      end

      def procedures
        @procedures ||= Procedures::Client.new(client: @client)
      end

      def realtime
        @realtime ||= Realtime::Client.new(client: @client)
      end
    end
  end
end
