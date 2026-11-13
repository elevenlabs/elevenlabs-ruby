# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module MergeProposals
      class Client
        def initialize(client:)
          @client = client
        end

        # List the proposals for an agent, newest first.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['status'] = params[:status] if params.key?(:status)
          query_params['source_branch_id'] = params[:source_branch_id] if params.key?(:source_branch_id)
          query_params['target_branch_id'] = params[:target_branch_id] if params.key?(:target_branch_id)
          query_params['search'] = params[:search] if params.key?(:search)
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals",
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::PaginatedResultAgentMergeProposalResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Record a request to merge a source branch into a target branch. Anyone with edit access can open one; merging it later is gated on write access to the target branch, so this is how a change reaches a protected branch the author cannot merge into themselves.
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::MergeProposals::Types::BodyCreateAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsPost.new(params.except(:agent_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::CreateAgentMergeProposalResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get a single merge_proposal.
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals/#{URI.encode_uri_component(params[:merge_proposal_id].to_s)}",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AgentMergeProposalResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Edit an open merge_proposal's title or description, or close it. The author closing it is recorded as withdrawn; anyone else as rejected.
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::MergeProposals::Types::BodyUpdateAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDPatch.new(params.except(:agent_id, :merge_proposal_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'PATCH',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals/#{URI.encode_uri_component(params[:merge_proposal_id].to_s)}",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AgentMergeProposalResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Approve a merge_proposal or request changes on it. A user's latest review replaces their previous one. Non-admins need an approval from another user before the merge is allowed.
        def submit_review(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::MergeProposals::Types::BodyReviewAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDReviewsPost.new(params.except(:agent_id, :merge_proposal_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals/#{URI.encode_uri_component(params[:merge_proposal_id].to_s)}/reviews",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AgentMergeProposalResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Leave a comment on a merge_proposal without recording a review verdict. Unlike reviews, comments accumulate and can still be added once the merge_proposal is merged or closed.
        def add_comment(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::MergeProposals::Types::BodyCommentOnAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDCommentsPost.new(params.except(:agent_id, :merge_proposal_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals/#{URI.encode_uri_component(params[:merge_proposal_id].to_s)}/comments",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AgentMergeProposalResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Execute the merge. The caller must have write access to the target branch (admins only, for a protected branch), so this is where a reviewer approves and merges a request opened by someone who could not.
        def merge(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Agents::MergeProposals::Types::BodyMergeAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDMergePost.new(params.except(:agent_id, :merge_proposal_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/merge-proposals/#{URI.encode_uri_component(params[:merge_proposal_id].to_s)}/merge",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AgentMergeProposalResponse.load(body) }
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
