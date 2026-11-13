# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module SpeechEngine
    class Client
      def initialize(client:)
        @client = client
      end

      # Returns a paginated list of Speech Engine resources.
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['search'] = params[:search] if params.key?(:search)
        query_params['sort_direction'] = params[:sort_direction] if params.key?(:sort_direction)
        query_params['sort_by'] = params[:sort_by] if params.key?(:sort_by)
        query_params['cursor'] = params[:cursor] if params.key?(:cursor)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/speech-engine',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ListSpeechEnginesResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Create a new Speech Engine resource
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::SpeechEngine::Types::CreateSpeechEngineRequest.new(params)
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/speech-engine',
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::SpeechEngineResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Retrieve a Speech Engine resource
      def get(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/speech-engine/#{URI.encode_uri_component(params[:speech_engine_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::SpeechEngineResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Update a Speech Engine resource (partial update)
      def update(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::SpeechEngine::Types::UpdateSpeechEngineRequest.new(params.except(:speech_engine_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'PATCH',
          path: "v1/speech-engine/#{URI.encode_uri_component(params[:speech_engine_id].to_s)}",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::SpeechEngineResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Delete a Speech Engine resource
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/speech-engine/#{URI.encode_uri_component(params[:speech_engine_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        return if code.between?(200, 299)

        error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
        error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
        raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
      end

      # Create a new Speech Engine resource by duplicating an existing one
      def duplicate(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request_body = ::Elevenlabs::Types::DuplicateSpeechEngineRequest.new(params.except(:speech_engine_id))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: "v1/speech-engine/#{URI.encode_uri_component(params[:speech_engine_id].to_s)}/duplicate",
          body: request_body.to_h,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::SpeechEngineResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Opens a WebSocket connection to the `speech_engine` channel.
      #
      # @param eleven_labs_speech_engine_authorization [String, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [SpeechEngineSocket] The connected socket; it is closed when the block returns.
      # @return [SpeechEngineSocket, Object] The connected socket, or the block's value when a block is given.
      def upstream(eleven_labs_speech_engine_authorization: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        SpeechEngineSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: '/speech-engine/upstream',
            client_query: @client.websocket_query,
            request_options: request_options,
          ),
          headers: -> { ::Elevenlabs::Internal::WebSocket::Handshake.headers({ 'X-ElevenLabs-Speech-Engine-Authorization' => eleven_labs_speech_engine_authorization }, client_headers: @client.websocket_headers, credentials: -> { @client.websocket_credentials }, request_options: request_options) },
          reconnect: reconnect,
          connect_timeout: connect_timeout,
          &block
        )
      end
    end
  end
end
