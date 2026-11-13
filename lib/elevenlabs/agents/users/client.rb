# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Users
      class Client
        def initialize(client:)
          @client = client
        end

        # Get distinct users from conversations with pagination.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['agent_id'] = params[:agent_id] if params.key?(:agent_id)
          query_params['branch_id'] = params[:branch_id] if params.key?(:branch_id)
          query_params['call_start_before_unix'] = params[:call_start_before_unix] if params.key?(:call_start_before_unix)
          query_params['call_start_after_unix'] = params[:call_start_after_unix] if params.key?(:call_start_after_unix)
          query_params['search'] = params[:search] if params.key?(:search)
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['sort_by'] = params[:sort_by] if params.key?(:sort_by)
          query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/convai/users',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetConversationUsersPageResponseModel.load(body) }
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
