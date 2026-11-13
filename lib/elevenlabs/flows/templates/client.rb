# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Flows
    module Templates
      class Client
        def initialize(client:)
          @client = client
        end

        # List the published flows templates in your workspace, together with each runnable version's inputs and outputs. Use the ids here as `template_id` / `version_id` on `POST /v1/flows/templates/{template_id}/runs`. Versions built on models that are not available to you through the API are left out, so `versions` is empty when none of a template's published versions is runnable through this API. Templates shared with you by link, or published to Explore from another workspace, are not listed but can still be fetched and run by `template_id`.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['versions_per_template'] = params[:versions_per_template] if params.key?(:versions_per_template)
          query_params['search'] = params[:search] if params.key?(:search)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/flows/templates',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::TemplateListResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Retrieve one flows template, together with each runnable version's inputs and outputs. `versions` is empty when no published version is runnable through this API. Works for any template you can open, including templates shared with you by link or published to Explore from another workspace, which `GET /v1/flows/templates` does not list.
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['versions_per_template'] = params[:versions_per_template] if params.key?(:versions_per_template)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/flows/templates/#{URI.encode_uri_component(params[:template_id].to_s)}",
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::TemplateSummary.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        def runs
          @runs ||= Runs::Client.new(client: @client)
        end
      end
    end
  end
end
