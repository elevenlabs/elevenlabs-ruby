# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Team
      module Invites
        class Client
          def initialize(client:)
            @client = client
          end

          # List the workspace's pending invites.
          def list(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: 'v1/reception/team/invites',
              headers: headers,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionTeamInviteResponse].coerce(::JSON.parse(body, symbolize_names: false)) }
              result&.each { |item| item.validate! if item.respond_to?(:validate!) }
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Email an invite to join the workspace. A pending invite takes a seat, so this is refused once members and invites reach the plan's team limit.
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Team::Invites::Types::CreateTeamInviteRequest.new(params.except(:xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: 'v1/reception/team/invites',
              body: request_body.to_h.except('xi-workspace-id'),
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

          # Cancel a pending invite, freeing its seat.
          def cancel(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            headers = {}
            headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
            request_body = ::Elevenlabs::Reception::Team::Invites::Types::BodySmbCancelTeamInvite.new(params.except(:xi_workspace_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: 'v1/reception/team/invites',
              body: request_body.to_h.except('xi-workspace-id'),
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
