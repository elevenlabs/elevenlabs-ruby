# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Reception
    module PhoneNumbers
      class Client
        def initialize(client:)
          @client = client
        end

        # List the workspace's phone numbers and the receptionist each one rings. A number with no `customer_facing_agent_id` is held by the workspace but not attached to a receptionist yet.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/reception/phone-numbers/assignments',
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionPhoneAssignment].coerce(::JSON.parse(body, symbolize_names: false)) }
            result&.each { |item| item.validate! if item.respond_to?(:validate!) }
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Give a receptionist a phone number. A number the workspace already holds but has not attached is used first. Otherwise, in the US and Canada, a number with one of the requested `area_codes` is taken from the pool or bought, falling back to any number in the business's country. In countries that require paperwork, the number is issued right away but takes public calls only once the workspace's own registration is approved (see `accepts_public_calls`). Counts toward the plan's phone number limit, and free plans can take only a few new numbers a day. Returns 404 when no number is available and 403 `telephony_managed_by_reseller` when the reseller supplies the workspace's numbers from its own Twilio account or SIP trunk and none is free.
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request_body = ::Elevenlabs::Reception::PhoneNumbers::Types::CreatePhoneAssignmentRequest.new(params.except(:xi_workspace_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/reception/phone-numbers/assignments',
            body: request_body.to_h.except('xi-workspace-id'),
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionPhoneAssignment.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Move a phone number to a different receptionist in the same workspace, which answers its calls from then on. Returns 409 `phone_number_not_attached` for a number no receptionist answers yet (attach it with `POST /v1/reception/phone-numbers/assignments`).
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request_body = ::Elevenlabs::Reception::PhoneNumbers::Types::ReassignPhoneRequest.new(params.except(:phone_assignment_id, :xi_workspace_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'PATCH',
            path: "v1/reception/phone-numbers/assignments/#{URI.encode_uri_component(params[:phone_assignment_id].to_s)}",
            body: request_body.to_h.except('phone_assignment_id', 'xi-workspace-id'),
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionPhoneAssignment.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Remove a phone number from the workspace. A pool number goes back to the pool it came from. A number the business brought from its own Twilio account, or one issued in a country that requires paperwork, is released at Twilio and cannot be recovered. Returns 403 `telephony_managed_by_reseller` when the reseller supplies the workspace's numbers from its own Twilio account or SIP trunk.
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/reception/phone-numbers/assignments/#{URI.encode_uri_component(params[:phone_assignment_id].to_s)}",
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          return if code.between?(200, 299)

          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end
    end
  end
end
