# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module Conversations
      module Files
        class Client
          def initialize(client:)
            @client = client
          end

          # Download a file the user attached to a conversation, including while the conversation is still active.
          #
          # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
          # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
          # start before the server has finished. `read` on the Enumerator returns the whole body as one
          # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
          # from this call.
          #
          # @return [Enumerator]
          def get(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'GET',
              path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}/files/#{URI.encode_uri_component(params[:file_id].to_s)}",
              accept: 'application/octet-stream',
              request_options: request_options,
            )
            ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
              code = response.code.to_i
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Remove a file upload from a conversation. Only possible if the file hasn't already been used in the conversation.
          def delete(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}/files/#{URI.encode_uri_component(params[:file_id].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ConvAiFileUploadResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Upload an image, PDF, or text file for a conversation. Returns a unique file ID that can be used to reference the file in the conversation.
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            body = ::Elevenlabs::Internal::Multipart::FormData.new
            body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
            request = ::Elevenlabs::Internal::Multipart::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/convai/conversations/#{URI.encode_uri_component(params[:conversation_id].to_s)}/files",
              body: body,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ConvAiFileUploadResponseModel.load(body) }
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
