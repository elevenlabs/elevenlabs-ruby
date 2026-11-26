# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Reception
    module Staff
      class Client
        def initialize(client:)
          @client = client
        end

        # Get all staff for the current workspace
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/reception/staff',
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ReceptionStaffResource].coerce(::JSON.parse(body, symbolize_names: false)) }
            result&.each { |item| item.validate! if item.respond_to?(:validate!) }
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Create a new staff member
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request_body = ::Elevenlabs::Reception::Staff::Types::ReceptionCreateStaffRequest.new(params.except(:xi_workspace_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/reception/staff',
            body: request_body.to_h.except('xi-workspace-id'),
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionStaffResource.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Get a specific staff member by ID
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/reception/staff/#{URI.encode_uri_component(params[:staff_id].to_s)}",
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionStaffResource.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Update an existing staff member. Only the fields sent are changed.
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request_body = ::Elevenlabs::Reception::Staff::Types::ReceptionUpdateStaffRequestPatch.new(params.except(:staff_id, :xi_workspace_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'PUT',
            path: "v1/reception/staff/#{URI.encode_uri_component(params[:staff_id].to_s)}",
            body: request_body.to_h.except('staff_id', 'xi-workspace-id'),
            headers: headers,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ReceptionStaffResource.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Delete a staff member
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          headers = {}
          headers['xi-workspace-id'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:xi_workspace_id]) if params.key?(:xi_workspace_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/reception/staff/#{URI.encode_uri_component(params[:staff_id].to_s)}",
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
