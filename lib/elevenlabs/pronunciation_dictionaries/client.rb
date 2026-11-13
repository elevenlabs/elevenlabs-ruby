# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module PronunciationDictionaries
    class Client
      def initialize(client:)
        @client = client
      end

      # Creates a new pronunciation dictionary from a lexicon .PLS file
      def create_from_file(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add(name: 'name', value: params[:name]) if params.key?(:name)
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add(name: 'description', value: params[:description]) if params.key?(:description)
        body.add(name: 'workspace_access', value: params[:workspace_access]) if params.key?(:workspace_access)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/pronunciation-dictionaries/add-from-file',
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AddPronunciationDictionaryResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Creates a new pronunciation dictionary from provided rules.
      def create_from_rules(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::PronunciationDictionaries::Types::BodyAddAPronunciationDictionaryV1PronunciationDictionariesAddFromRulesPost.new(params)
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/pronunciation-dictionaries/add-from-rules',
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AddPronunciationDictionaryResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Get metadata for a pronunciation dictionary
      def get(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/pronunciation-dictionaries/#{URI.encode_uri_component(params[:pronunciation_dictionary_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetPronunciationDictionaryWithRulesResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Partially update the pronunciation dictionary without changing the version
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::PronunciationDictionaries::Types::BodyUpdatePronunciationDictionaryV1PronunciationDictionariesPronunciationDictionaryIDPatch.new(params.except(:pronunciation_dictionary_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'PATCH',
          path: "v1/pronunciation-dictionaries/#{URI.encode_uri_component(params[:pronunciation_dictionary_id].to_s)}",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetPronunciationDictionaryMetadataResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Get a PLS file with a pronunciation dictionary version rules
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def download(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/pronunciation-dictionaries/#{URI.encode_uri_component(params[:dictionary_id].to_s)}/#{URI.encode_uri_component(params[:version_id].to_s)}/download",
          accept: 'text/plain',
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Get a list of the pronunciation dictionaries you have access to and their metadata
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['cursor'] = params[:cursor] if params.key?(:cursor)
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['sort'] = params[:sort] if params.key?(:sort)
        query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
        query_params['include_archived'] = params[:include_archived] if params.key?(:include_archived)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/pronunciation-dictionaries',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::GetPronunciationDictionariesMetadataResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      def rules
        @rules ||= Rules::Client.new(client: @client)
      end
    end
  end
end
