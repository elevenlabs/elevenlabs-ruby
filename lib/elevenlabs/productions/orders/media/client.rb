# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Productions
    module Orders
      module Media
        class Client
          def initialize(client:)
            @client = client
          end

          # Registers a media file with an order, either by uploading it directly or by providing a URL to fetch it from. Exactly one of `media` or `media_url` must be provided. The registered media can then be referenced when adding order items.
          def register(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            body = ::Elevenlabs::Internal::Multipart::FormData.new
            body.add(name: 'declared_language', value: params[:declared_language]) if params.key?(:declared_language)
            body.add_file(name: 'media', file: params[:media]) if params.key?(:media)
            body.add(name: 'media_url', value: params[:media_url]) if params.key?(:media_url)
            body.add(name: 'media_url_filename', value: params[:media_url_filename]) if params.key?(:media_url_filename)
            body.add(name: 'media_url_content_type', value: params[:media_url_content_type]) if params.key?(:media_url_content_type)
            request = ::Elevenlabs::Internal::Multipart::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/productions/orders/#{URI.encode_uri_component(params[:order_id].to_s)}/media",
              body: body,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::RegisterMediaResponse.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Retrieves metadata and a time-limited download URL for a previously uploaded media file.
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/productions/orders/#{URI.encode_uri_component(params[:order_id].to_s)}/media/#{URI.encode_uri_component(params[:media_id].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::OrderMediaResponse.load(body) }
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
end
