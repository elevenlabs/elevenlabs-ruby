# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Reception
    module Team
      module Members
        class Client
          def initialize(client:, base_url: nil, environment: nil)
            @client = client
            @base_url = base_url
            @environment = environment
          end

          # List the workspace's members, suspended members last.
          def list(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/reception/team/members',
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionTeamMemberResponse].coerce(::JSON.parse(body, symbolize_names: false)) }
              result&.each { |item| item.validate! if item.respond_to?(:validate!) }
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Promote a member to admin or demote an admin to member.
          def update_role(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Team::Members::Types::BodySmbUpdateTeamMemberRole.new(params.except(:user_id, :xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'PATCH',
              path: "v1/reception/team/members/#{URI.encode_uri_component(params[:user_id].to_s)}",
              body: request_body.to_h,
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Hash[String, String].coerce(::JSON.parse(body, symbolize_names: false)) }
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Remove a member from the workspace. Their seat goes to a suspended member, if any.
          def remove(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/reception/team/members/#{URI.encode_uri_component(params[:user_id].to_s)}",
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Hash[String, String].coerce(::JSON.parse(body, symbolize_names: false)) }
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
