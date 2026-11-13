# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module AuditLogs
      class Client
        def initialize(client:)
          @client = client
        end

        # Returns the audit log for the workspace. Requires enterprise tier and the audit_log_read permission.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['limit'] = params[:limit] if params.key?(:limit)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          query_params['time_from_unix_ms'] = params[:time_from_unix_ms] if params.key?(:time_from_unix_ms)
          query_params['time_to_unix_ms'] = params[:time_to_unix_ms] if params.key?(:time_to_unix_ms)
          query_params['actor_uid'] = params[:actor_uid] if params.key?(:actor_uid)
          query_params['class_name'] = params[:class_name] if params.key?(:class_name)
          query_params['activity_name'] = params[:activity_name] if params.key?(:activity_name)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/workspace/audit-logs',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::WorkspaceAuditLogsPageResponse.load(body) }
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
