# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Dubbing
    module Project
      module Language
        class Client
          def initialize(client:)
            @client = client
          end

          # List a project's language targets, cursor-paginated, each with signed output URLs once it has produced an output.
          def list(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            query_params = {}
            query_params['cursor'] = params[:cursor] if params.key?(:cursor)
            query_params['page_size'] = params[:page_size] if params.key?(:page_size)
            query_params['status'] = params[:status] if params.key?(:status)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language",
              query: query_params,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingLanguageListResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Add a language to dub a project into, and queue the dub.
          #
          # This is the call that produces dubbed audio, and it is billed per generation. The target is created `queued` and starts as soon as the project is `ready`, so it can be added at any point after the project is created. It inherits the project's dubbing model and cannot pick another.
          #
          # A project created with `webhook_ids` sends a `dubbing_language_completed` event carrying the output download URLs, so we recommend subscribing rather than polling this target to completion.
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request_body = ::Elevenlabs::Dubbing::Project::Language::Types::BodyCreateDubbingLanguageTargetV1DubbingProjectProjectIDLanguagePost.new(params.except(:project_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language",
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingLanguageResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Full language-target detail. Once the target reports `completed`, `outputs` carries the signed download URLs. To learn when that happens, we recommend the project's `webhook_ids` subscription rather than polling this endpoint; fetch here when a delivered URL has expired, or to reconcile after an edit.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language/#{URI.encode_uri_component(params[:language_id].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingLanguageResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Delete a language target and its outputs, leaving the project and its other languages intact. This cannot be undone, and a dub already running is still billed.
          def delete(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language/#{URI.encode_uri_component(params[:language_id].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            return if code.between?(200, 299)

            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end

          def transcript
            @transcript ||= Transcript::Client.new(client: @client)
          end
        end
      end
    end
  end
end
