# frozen_string_literal: true

module Elevenlabs
  module Music
    class Client
      def initialize(client:)
        @client = client
      end

      # Generate background music from one or more video files. Videos are combined in order. Optional description and style tags influence the generated music.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def video_to_music(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        params[:videos]&.each { |item| body.add_file(name: 'videos', file: item) }
        body.add(name: 'description', value: params[:description]) if params.key?(:description)
        params[:tags]&.each { |item| body.add(name: 'tags', value: item) }
        body.add(name: 'model_id', value: params[:model_id]) if params.key?(:model_id)
        body.add(name: 'add_sfx', value: params[:add_sfx]) if params.key?(:add_sfx)
        body.add(name: 'separate_tracks', value: params[:separate_tracks]) if params.key?(:separate_tracks)
        body.add(name: 'use_audio_as_reference', value: params[:use_audio_as_reference]) if params.key?(:use_audio_as_reference)
        body.add(name: 'sign_with_c2pa', value: params[:sign_with_c2pa]) if params.key?(:sign_with_c2pa)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music/video-to-music',
          query: query_params,
          body: body,
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          raise error_class.new(response.body, code: code, headers: response.to_hash)
        end
      end

      # Compose a song from a prompt or a composition plan.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def compose(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        request_body = ::Elevenlabs::Music::Types::BodyComposeMusicV1MusicPost.new(params.except(:output_format, :enable_logging))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music',
          query: query_params,
          body: request_body.to_h,
          accept: 'audio/*',
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Compose a song from a prompt or a composition plan.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def compose_detailed(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        request_body = ::Elevenlabs::Music::Types::BodyComposeMusicWithADetailedResponseV1MusicDetailedPost.new(params.except(:output_format, :enable_logging))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music/detailed',
          query: query_params,
          body: request_body.to_h,
          accept: 'multipart/mixed',
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Stream a song and its detailed metadata using Server-Sent Events (SSE).
      def compose_detailed_stream(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        request_body = ::Elevenlabs::Music::Types::BodyStreamComposedMusicWithADetailedResponseV1MusicDetailedStreamPost.new(params.except(:output_format, :enable_logging))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music/detailed/stream',
          query: query_params,
          body: request_body.to_h,
          accept: 'text/event-stream',
          request_options: request_options,
        )
        decode_event = ->(frame) { frame }
        ::Elevenlabs::Internal::Http::EventStream.decode(@client, request, decode_event) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Stream a composed song from a prompt or a composition plan.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def stream(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        request_body = ::Elevenlabs::Music::Types::BodyStreamComposedMusicV1MusicStreamPost.new(params.except(:output_format, :enable_logging))
        request_body.validate! if request_body.respond_to?(:validate!)
        request = ::Elevenlabs::Internal::JSON::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music/stream',
          query: query_params,
          body: request_body.to_h,
          accept: 'audio/*',
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Upload a music file to be later used for inpainting. Price for uploading is the same as the one for song generation. All uploaded content gets inspected for copyright infringement. If copyrighted content is detected, half of the request cost is still charged.
      def upload(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add(name: 'extract_composition_plan', value: params[:extract_composition_plan]) if params.key?(:extract_composition_plan)
        body.add(name: 'with_timestamps', value: params[:with_timestamps]) if params.key?(:with_timestamps)
        body.add(name: 'with_waveform_visual', value: params[:with_waveform_visual]) if params.key?(:with_waveform_visual)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music/upload',
          body: body,
          request_options: request_options,
        )
        response = @client.send(request)
        code = response.code.to_i
        if code.between?(200, 299)
          result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::MusicUploadResponse.load(body) }
          result.validate! if result.respond_to?(:validate!)
          result
        else
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      # Separate an audio file into individual stems. This endpoint might have high latency, depending on the length of the audio file.
      #
      # Returns a lazy, single-use Enumerator of the response body as binary chunks. The request is sent
      # on the first iteration and each chunk is yielded as it arrives, so playback or a file write can
      # start before the server has finished. `read` on the Enumerator returns the whole body as one
      # binary String. A non-2xx response raises its typed error from the first iteration or `read`, not
      # from this call.
      #
      # @return [Enumerator]
      def separate_stems(request_options: {}, **params)
        params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
        query_params = {}
        query_params['output_format'] = params[:output_format] if params.key?(:output_format)
        query_params['enable_logging'] = params[:enable_logging] if params.key?(:enable_logging)
        body = ::Elevenlabs::Internal::Multipart::FormData.new
        body.add_file(name: 'file', file: params[:file]) if params.key?(:file)
        body.add(name: 'stem_variation_id', value: params[:stem_variation_id]) if params.key?(:stem_variation_id)
        body.add(name: 'sign_with_c2pa', value: params[:sign_with_c2pa]) if params.key?(:sign_with_c2pa)
        request = ::Elevenlabs::Internal::Multipart::Request.new(
          base_url: request_options[:base_url],
          method: 'POST',
          path: 'v1/music/stem-separation',
          query: query_params,
          body: body,
          request_options: request_options,
        )
        ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
          code = response.code.to_i
          error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
          error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
          raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
        end
      end

      def composition_plan
        @composition_plan ||= CompositionPlan::Client.new(client: @client)
      end

      def finetunes
        @finetunes ||= Finetunes::Client.new(client: @client)
      end
    end
  end
end
