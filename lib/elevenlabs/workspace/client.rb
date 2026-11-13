# frozen_string_literal: true

module Elevenlabs
  module Workspace
    class Client
      def initialize(client:)
        @client = client
      end

      # Set the workspace-wide Third-Party Disabling policy. When set, it forces, for every API key in the workspace, whether the holder of a key (potentially a third party who found it) may disable it via the self-disable endpoint or when it leaks publicly — overriding each key's own setting. Pass `true` to allow it for all keys, `false` to forbid it for all keys, or `null` to clear the override so per-key values and the plan default apply again. Workspace admins only.
      def set_third_party_disabling_policy(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Workspace::Types::BodySetWorkspaceThirdPartyDisablingPolicyV1WorkspacesAPIKeysThirdPartyDisablingPost.new(params)
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/workspaces/api-keys/third-party-disabling',
          body: request_body.to_h,
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

      def audit_logs
        @audit_logs ||= AuditLogs::Client.new(client: @client)
      end

      def auth_connections
        @auth_connections ||= AuthConnections::Client.new(client: @client)
      end

      def groups
        @groups ||= Groups::Client.new(client: @client)
      end

      def invites
        @invites ||= Invites::Client.new(client: @client)
      end

      def members
        @members ||= Members::Client.new(client: @client)
      end

      def resources
        @resources ||= Resources::Client.new(client: @client)
      end

      def usage
        @usage ||= Usage::Client.new(client: @client)
      end

      def analytics
        @analytics ||= Analytics::Client.new(client: @client)
      end
    end
  end
end
