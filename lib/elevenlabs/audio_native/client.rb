# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module AudioNative
    class Client
      def initialize(client:)
        @client = client
      end

      # Creates Audio Native enabled project, optionally starts conversion and returns project ID and embeddable HTML snippet.
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add(name: 'name', value: params[:name]) if params.key?(:name)
        body.add(name: 'image', value: params[:image]) if params.key?(:image)
        body.add(name: 'author', value: params[:author]) if params.key?(:author)
        body.add(name: 'title', value: params[:title]) if params.key?(:title)
        body.add(name: 'small', value: params[:small]) if params.key?(:small)
        body.add(name: 'text_color', value: params[:text_color]) if params.key?(:text_color)
        body.add(name: 'background_color', value: params[:background_color]) if params.key?(:background_color)
        body.add(name: 'sessionization', value: params[:sessionization]) if params.key?(:sessionization)
        body.add(name: 'voice_id', value: params[:voice_id]) if params.key?(:voice_id)
        body.add(name: 'model_id', value: params[:model_id]) if params.key?(:model_id)
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add(name: 'auto_convert', value: params[:auto_convert]) if params.key?(:auto_convert)
        body.add(name: 'apply_text_normalization', value: params[:apply_text_normalization]) if params.key?(:apply_text_normalization)
        params[:pronunciation_dictionary_locators]&.each { |item| body.add(name: 'pronunciation_dictionary_locators', value: item) }
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/audio-native',
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AudioNativeCreateProjectResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Get player settings for the specific project.
      def get_settings(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/audio-native/#{URI.encode_uri_component(params[:project_id].to_s)}/settings",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetAudioNativeProjectSettingsResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Updates content for the specific AudioNative Project.
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add(name: 'auto_convert', value: params[:auto_convert]) if params.key?(:auto_convert)
        body.add(name: 'auto_publish', value: params[:auto_publish]) if params.key?(:auto_publish)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/audio-native/#{URI.encode_uri_component(params[:project_id].to_s)}/content",
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AudioNativeEditContentResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Finds an AudioNative project matching the provided URL, extracts content from the URL, updates the project content, and queues it for conversion and auto-publishing.
      def update_content_from_url(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::AudioNative::Types::BodyUpdateAudioNativeContentFromURLV1AudioNativeContentPost.new(params)
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/audio-native/content',
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AudioNativeEditContentResponseModel.load(body) }
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
