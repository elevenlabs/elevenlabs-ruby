# frozen_string_literal: true

module Elevenlabs
  module Studio
    class Client
      def initialize(client:)
        @client = client
      end

      # Create and auto-convert a podcast project. Currently, the LLM cost is covered by us but you will still be charged for the audio generation. In the future, you will be charged for both the LLM and audio generation costs.
      def create_podcast(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        headers = {}
        headers['safety-identifier'] = ::Elevenlabs::Internal::Types::Utils.simple_param(params[:safety_identifier]) if params.key?(:safety_identifier)
        request_body = ::Elevenlabs::Studio::Types::BodyCreatePodcastV1StudioPodcastsPost.new(params.except(:safety_identifier))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/studio/podcasts',
          body: request_body.to_h,
          headers: headers,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::PodcastProjectResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      def projects
        @projects ||= Projects::Client.new(client: @client)
      end
    end
  end
end
