# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Studio
    module Projects
      class Client
        def initialize(client:)
          @client = client
        end

        # Returns a list of your Studio projects with metadata.
        def list(request_options: {}, **params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: 'v1/studio/projects',
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetProjectsResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Creates a new Studio project, it can be either initialized as blank, from a document or from a URL.
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          body = ::Elevenlabs::Internal::Multipart::FormData.new
          body.add(name: 'name', value: params[:name]) if params.key?(:name)
          body.add(name: 'default_title_voice_id', value: params[:default_title_voice_id]) if params.key?(:default_title_voice_id)
          body.add(name: 'default_paragraph_voice_id', value: params[:default_paragraph_voice_id]) if params.key?(:default_paragraph_voice_id)
          body.add(name: 'default_model_id', value: params[:default_model_id]) if params.key?(:default_model_id)
          body.add(name: 'from_url', value: params[:from_url]) if params.key?(:from_url)
          body.add_file(name: 'from_document', file: params[:from_document]) if params.key?(:from_document)
          body.add(name: 'from_content_json', value: params[:from_content_json]) if params.key?(:from_content_json)
          body.add(name: 'quality_preset', value: params[:quality_preset]) if params.key?(:quality_preset)
          body.add(name: 'title', value: params[:title]) if params.key?(:title)
          body.add(name: 'author', value: params[:author]) if params.key?(:author)
          body.add(name: 'description', value: params[:description]) if params.key?(:description)
          params[:genres]&.each { |item| body.add(name: 'genres', value: item) }
          body.add(name: 'target_audience', value: params[:target_audience]) if params.key?(:target_audience)
          body.add(name: 'language', value: params[:language]) if params.key?(:language)
          body.add(name: 'content_type', value: params[:content_type]) if params.key?(:content_type)
          body.add(name: 'original_publication_date', value: params[:original_publication_date]) if params.key?(:original_publication_date)
          body.add(name: 'mature_content', value: params[:mature_content]) if params.key?(:mature_content)
          body.add(name: 'isbn_number', value: params[:isbn_number]) if params.key?(:isbn_number)
          body.add(name: 'acx_volume_normalization', value: params[:acx_volume_normalization]) if params.key?(:acx_volume_normalization)
          body.add(name: 'volume_normalization', value: params[:volume_normalization]) if params.key?(:volume_normalization)
          params[:pronunciation_dictionary_locators]&.each { |item| body.add(name: 'pronunciation_dictionary_locators', value: item) }
          body.add(name: 'callback_url', value: params[:callback_url]) if params.key?(:callback_url)
          body.add(name: 'fiction', value: params[:fiction]) if params.key?(:fiction)
          body.add(name: 'apply_text_normalization', value: params[:apply_text_normalization]) if params.key?(:apply_text_normalization)
          body.add(name: 'auto_convert', value: params[:auto_convert]) if params.key?(:auto_convert)
          body.add(name: 'auto_assign_voices', value: params[:auto_assign_voices]) if params.key?(:auto_assign_voices)
          body.add(name: 'source_type', value: params[:source_type]) if params.key?(:source_type)
          params[:voice_settings]&.each { |item| body.add(name: 'voice_settings', value: item) }
          body.add(name: 'create_publishing_read', value: params[:create_publishing_read]) if params.key?(:create_publishing_read)
          request = ::Elevenlabs::Internal::Multipart::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: 'v1/studio/projects',
            body: body,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AddProjectResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Returns information about a specific Studio project. This endpoint returns more detailed information about a project than `GET /v1/studio`.
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          query_params = {}
          query_params['share_id'] = params[:share_id] if params.key?(:share_id)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}",
            query: query_params,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ProjectExtendedResponse.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Updates the specified Studio project by setting the values of the parameters passed.
        def update(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request_body = ::Elevenlabs::Studio::Projects::Types::BodyUpdateStudioProjectV1StudioProjectsProjectIDPost.new(params.except(:project_id))
          request_body.validate! if request_body.respond_to?(:validate!)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}",
            body: request_body.to_h,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::EditProjectResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Deletes a Studio project.
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DeleteProjectResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Starts conversion of a Studio project and all of its chapters.
        def convert(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}/convert",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ConvertProjectResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Returns a list of chapter IDs that have muted tracks in a project.
        def get_muted_tracks(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}/muted-tracks",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ProjectMutedTracksResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        def pronunciation_dictionaries
          @pronunciation_dictionaries ||= PronunciationDictionaries::Client.new(client: @client)
        end

        def content
          @content ||= Content::Client.new(client: @client)
        end

        def snapshots
          @snapshots ||= Snapshots::Client.new(client: @client)
        end

        def chapters
          @chapters ||= Chapters::Client.new(client: @client)
        end
      end
    end
  end
end
