# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Dubbing
    module Transcripts
      class Client
        def initialize(client:)
          @client = client
        end

        # Fetch the transcript for one of the languages in a dub.
        # @deprecated
        def get(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'GET',
            path: "v1/dubbing/#{URI.encode_uri_component(params[:dubbing_id].to_s)}/transcripts/#{URI.encode_uri_component(params[:language_code].to_s)}/format/#{URI.encode_uri_component(params[:format_type].to_s)}",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingTranscriptsResponseModel.load(body) }
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
