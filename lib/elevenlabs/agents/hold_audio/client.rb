# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Agents
    module HoldAudio
      class Client
        def initialize(client:)
          @client = client
        end

        # Sets the custom hold audio played on loop to callers waiting in the agent's concurrency wait queue. Replaces any previously uploaded clip.
        def create(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          body = ::Elevenlabs::Internal::Multipart::FormData.new
          body.add_file(name: 'hold_audio_file', file: params[:hold_audio_file]) if params.key?(:hold_audio_file)
          request = ::Elevenlabs::Internal::Multipart::Request.new(
            base_url: request_options[:base_url],
            method: 'POST',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/hold-audio",
            body: body,
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::PostAgentHoldAudioResponseModel.load(body) }
            result.validate! if result.respond_to?(:validate!)
            result
          else
            error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
            error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
            raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
          end
        end

        # Removes the agent's custom hold audio; queued callers hear the default hold tone again.
        def delete(request_options: {}, **params)
          params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
          request = ::Elevenlabs::Internal::JSON::Request.new(
            base_url: request_options[:base_url],
            method: 'DELETE',
            path: "v1/convai/agents/#{URI.encode_uri_component(params[:agent_id].to_s)}/hold-audio",
            request_options: request_options,
          )
          response = @client.send(request)
          code = response.code.to_i
          if code.between?(200, 299)
            result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DeleteAgentHoldAudioResponseModel.load(body) }
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
