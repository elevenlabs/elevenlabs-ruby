# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Studio
    module Projects
      module Chapters
        module Snapshots
          class Client
            def initialize(client:)
              @client = client
            end

            # Gets information about all the snapshots of a chapter. Each snapshot can be downloaded as audio. Whenever a chapter is converted a snapshot will automatically be created.
            def list(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}/chapters/#{URI.encode_uri_component(params[:chapter_id].to_s)}/snapshots",
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ChapterSnapshotsResponse.load(body) }
                result.validate! if result.respond_to?(:validate!)
                result
              else
                error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
                error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
                raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
              end
            end

            # Returns the chapter snapshot.
            def get(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}/chapters/#{URI.encode_uri_component(params[:chapter_id].to_s)}/snapshots/#{URI.encode_uri_component(params[:chapter_snapshot_id].to_s)}",
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::ChapterSnapshotExtendedResponseModel.load(body) }
                result.validate! if result.respond_to?(:validate!)
                result
              else
                error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
                error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
                raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
              end
            end

            # Stream the audio from a chapter snapshot. Use `GET /v1/studio/projects/{project_id}/chapters/{chapter_id}/snapshots` to return the snapshots of a chapter.
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
              request_body = ::Elevenlabs::Studio::Projects::Chapters::Snapshots::Types::BodyStreamChapterAudioV1StudioProjectsProjectIDChaptersChapterIDSnapshotsChapterSnapshotIDStreamPost.new(params.except(:project_id, :chapter_id, :chapter_snapshot_id))
              request_body.validate! if request_body.respond_to?(:validate!)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'POST',
                path: "v1/studio/projects/#{URI.encode_uri_component(params[:project_id].to_s)}/chapters/#{URI.encode_uri_component(params[:chapter_id].to_s)}/snapshots/#{URI.encode_uri_component(params[:chapter_snapshot_id].to_s)}/stream",
                body: request_body.to_h,
                accept: 'audio/mpeg',
                request_options: request_options,
              )
              ::Elevenlabs::Internal::Http::ByteStream.decode(@client, request) do |response|
                code = response.code.to_i
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
end
