# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module CustomerSupport
    module Tags
      class Client
        def initialize(client:)
          @client = client
        end

        # List active ticket tags for the workspace, newest first. Requires support read permission.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['ids'] = params[:ids] if params.key?(:ids)
          query_params['include_archived'] = params[:include_archived] if params.key?(:include_archived)
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/support/tags',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::PaginatedResultTicketTagResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Create a ticket tag for the workspace. Requires support write permission.
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::CustomerSupport::Tags::Types::CreateTicketTagRequest.new(params)
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/support/tags',
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::TicketTagResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Update a ticket tag. Requires support write permission.
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::CustomerSupport::Tags::Types::UpdateTicketTagRequest.new(params.except(:tag_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'PATCH',
            path: "v1/support/tags/#{URI.encode_uri_component(params[:tag_id].to_s)}",
            body: request_body.to_h.except('tag_id'),
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::TicketTagResponse.load(body) }
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
