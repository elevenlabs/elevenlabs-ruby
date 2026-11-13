# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Dubbing
    class Client
      def initialize(client:)
        @client = client
      end

      # List the dubs you have access to.
      # @deprecated
      def list(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['cursor'] = params[:cursor] if params.key?(:cursor)
        query_params['page_size'] = params[:page_size] if params.key?(:page_size)
        query_params['dubbing_status'] = params[:dubbing_status] if params.key?(:dubbing_status)
        query_params['dubbing_statuses'] = params[:dubbing_statuses] if params.key?(:dubbing_statuses)
        query_params['dubbing_models'] = params[:dubbing_models] if params.key?(:dubbing_models)
        query_params['target_language_codes'] = params[:target_language_codes] if params.key?(:target_language_codes)
        query_params['creation_sources'] = params[:creation_sources] if params.key?(:creation_sources)
        query_params['filter_by_creator'] = params[:filter_by_creator] if params.key?(:filter_by_creator)
        query_params['order_by'] = params[:order_by] if params.key?(:order_by)
        query_params['order_direction'] = params[:order_direction] if params.key?(:order_direction)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: 'v1/dubbing',
          query: query_params,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingMetadataPageResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Dubs a provided audio or video file into given language.
      # @deprecated
      def create(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add_file(name: 'csv_file', file: params[:csv_file]) if params.key?(:csv_file)
        body.add_file(name: 'foreground_audio_file', file: params[:foreground_audio_file]) if params.key?(:foreground_audio_file)
        body.add_file(name: 'background_audio_file', file: params[:background_audio_file]) if params.key?(:background_audio_file)
        body.add(name: 'name', value: params[:name]) if params.key?(:name)
        body.add(name: 'source_url', value: params[:source_url]) if params.key?(:source_url)
        body.add(name: 'source_lang', value: params[:source_lang]) if params.key?(:source_lang)
        body.add(name: 'target_lang', value: params[:target_lang]) if params.key?(:target_lang)
        body.add(name: 'target_accent', value: params[:target_accent]) if params.key?(:target_accent)
        body.add(name: 'num_speakers', value: params[:num_speakers]) if params.key?(:num_speakers)
        body.add(name: 'watermark', value: params[:watermark]) if params.key?(:watermark)
        body.add(name: 'start_time', value: params[:start_time]) if params.key?(:start_time)
        body.add(name: 'end_time', value: params[:end_time]) if params.key?(:end_time)
        body.add(name: 'highest_resolution', value: params[:highest_resolution]) if params.key?(:highest_resolution)
        body.add(name: 'drop_background_audio', value: params[:drop_background_audio]) if params.key?(:drop_background_audio)
        body.add(name: 'use_profanity_filter', value: params[:use_profanity_filter]) if params.key?(:use_profanity_filter)
        body.add(name: 'dubbing_studio', value: params[:dubbing_studio]) if params.key?(:dubbing_studio)
        body.add(name: 'disable_voice_cloning', value: params[:disable_voice_cloning]) if params.key?(:disable_voice_cloning)
        body.add(name: 'mode', value: params[:mode]) if params.key?(:mode)
        body.add(name: 'csv_fps', value: params[:csv_fps]) if params.key?(:csv_fps)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/dubbing',
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DoDubbingResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Returns metadata about a dubbing project, including whether it's still in progress or not
      # @deprecated
      def get(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'GET',
          path: "v1/dubbing/#{URI.encode_uri_component(params[:dubbing_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingMetadataResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Deletes a dubbing project.
      # @deprecated
      def delete(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'DELETE',
          path: "v1/dubbing/#{URI.encode_uri_component(params[:dubbing_id].to_s)}",
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DeleteDubbingResponseModel.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Opens a WebSocket connection to the `dubbing` channel.
      #
      # @param target_language [String]
      # @param source_language [String]
      # @param authorization [String, nil]
      # @param max_lag_s [Elevenlabs::V1DubbingLive::Types::DubbingLiveMaxLagS, nil]
      # @param cloning_strength [Integer, nil]
      # @param input_format [Elevenlabs::V1DubbingLive::Types::DubbingLiveInputFormat, nil]
      # @param input_num_channels [Elevenlabs::V1DubbingLive::Types::DubbingLiveInputNumChannels, nil]
      # @param output_format [Elevenlabs::V1DubbingLive::Types::DubbingLiveOutputFormat, nil]
      # @param client_session_id [String, nil]
      # @param reconnect [Hash, true, nil] Reopens the connection after the server closes or drops it:
      #   `:max_retries` (default 5) and `:backoff`, the first delay in seconds (default 1.0, doubling
      #   each retry). Off unless given.
      # @param connect_timeout [Numeric, nil] Seconds to wait for the handshake; 5 when nil.
      # @param request_options [Hash] `:base_url` replaces the server URL for this connection;
      #   `:additional_headers` and `:additional_query_parameters` are added to the handshake.
      # @yieldparam socket [DubbingSocket] The connected socket; it is closed when the block returns.
      # @return [DubbingSocket, Object] The connected socket, or the block's value when a block is given.
      def live(target_language:, source_language:, authorization: nil, max_lag_s: nil, cloning_strength: nil, input_format: nil, input_num_channels: nil, output_format: nil, client_session_id: nil, reconnect: nil, connect_timeout: nil, request_options: {}, &block)
        DubbingSocket.connect(
          url: ::Elevenlabs::Internal::WebSocket::Handshake.url(
            base_url: request_options[:base_url] || @client.websocket_base_url || @client.base_url || '',
            path: '/v1/dubbing/live',
            query: { 'target_language' => target_language, 'source_language' => source_language, 'authorization' => authorization, 'max_lag_s' => max_lag_s, 'cloning_strength' => cloning_strength, 'input_format' => input_format, 'input_num_channels' => input_num_channels, 'output_format' => output_format, 'client_session_id' => client_session_id },
            client_query: @client.websocket_query,
            request_options: request_options,
          ),
          headers: -> { ::Elevenlabs::Internal::WebSocket::Handshake.headers(client_headers: @client.websocket_headers, credentials: -> { @client.websocket_credentials }, request_options: request_options) },
          reconnect: reconnect,
          connect_timeout: connect_timeout,
          &block
        )
      end

      def project
        @project ||= Project::Client.new(client: @client)
      end

      def audio
        @audio ||= Audio::Client.new(client: @client)
      end

      def transcripts
        @transcripts ||= Transcripts::Client.new(client: @client)
      end
    end
  end
end
