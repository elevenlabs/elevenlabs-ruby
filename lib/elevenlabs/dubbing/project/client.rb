# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Dubbing
    module Project
      class Client
        def initialize(client:)
          @client = client
        end

        # List the dubbing projects in your workspace that you can access, newest first, cursor-paginated. Listed projects carry no `language_ids`; fetch a project, or list its language targets, to see them.
        def list(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['cursor'] = params[:cursor] if params.key?(:cursor)
          query_params['page_size'] = params[:page_size] if params.key?(:page_size)
          query_params['status'] = params[:status] if params.key?(:status)
          query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/dubbing/project',
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingProjectListResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Create a dubbing project from an uploaded file (`file`) or a source URL (`source_url`).
        #
        # Returns as soon as the project record exists, before the source has been fetched: the project starts `queued` and reaches `ready` once its source has been transcribed. Add a language target to it for each language you want, or pass `target_language` to queue the first one here.
        #
        # Creating a project incurs a minimum charge of one language: you are charged for at least one language's dubbing when the project is created, before any output exists. This charge prepays the first language target — the first target you add, or the one queued via `target_language`, consumes it — and each additional language is charged separately.
        #
        # Preparation can take minutes on a long source, so we recommend passing `webhook_ids` to be notified when the project turns `ready` or `failed`, rather than polling for it.
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          body = ::Elevenlabs::Internal::Multipart::FormData.new
          body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
          body.add(name: 'source_url', value: params[:source_url]) if params.key?(:source_url)
          body.add(name: 'reference', value: params[:reference]) if params.key?(:reference)
          body.add(name: 'source_language', value: params[:source_language]) if params.key?(:source_language)
          body.add(name: 'model_id', value: params[:model_id]) if params.key?(:model_id)
          params[:keyterms]&.each { |item| body.add(name: 'keyterms', value: item) }
          params[:webhook_ids]&.each { |item| body.add(name: 'webhook_ids', value: item) }
          body.add(name: 'target_language', value: params[:target_language]) if params.key?(:target_language)
          body.add_file(name: 'transcript', file: params[:transcript]) if params.key?(:transcript)
          request = ::Elevenlabs::Internal::Multipart::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/dubbing/project',
            body: body,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingProjectResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Full project detail, including the IDs of every language target under it. To follow a project to `ready`, we recommend a `webhook_ids` subscription rather than polling this endpoint.
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingProjectResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Delete a project, every language target under it, and their stored media and outputs. This cannot be undone, and a dub already running is still billed.
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          return if code.between?(200, 299)

          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end

        def language
          @language ||= Language::Client.new(client: @client)
        end

        def transcript
          @transcript ||= Transcript::Client.new(client: @client)
        end
      end
    end
  end
end
