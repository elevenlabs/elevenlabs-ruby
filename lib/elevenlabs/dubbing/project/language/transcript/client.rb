# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Dubbing
    module Project
      module Language
        module Transcript
          class Client
            def initialize(client:)
              @client = client
            end

            # A language target's transcript: source segments with their translations. Available once the target has produced an output. Returns a conflict while the target is still on its first dub, since it has no translations to return yet.
            def get(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'GET',
                path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language/#{URI.encode_uri_component(params[:language_id].to_s)}/transcript",
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingTargetTranscriptResponse.load(body) }
                result.validate! if result.respond_to?(:validate!)
                result
              else
                error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
                error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
                raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
              end
            end

            # Enterprise only. Edit a segment's translation for a language target. Omitted fields are left unchanged; an explicit null clears the field. Bumps the target's `revision` and marks it `stale` if it had already completed. The source transcript and the project's other languages are untouched, and no audio changes until you regenerate the target.
            def update_segment(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request_body = ::Elevenlabs::Dubbing::Project::Language::Transcript::Types::DubbingTargetSegmentUpdateRequest.new(params.except(:project_id, :language_id, :segment_id))
              request_body.validate! if request_body.respond_to?(:validate!)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'PATCH',
                path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language/#{URI.encode_uri_component(params[:language_id].to_s)}/transcript/segment/#{URI.encode_uri_component(params[:segment_id].to_s)}",
                body: request_body.to_h,
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingTargetSegmentUpdateResponse.load(body) }
                result.validate! if result.respond_to?(:validate!)
                result
              else
                error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
                error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
                raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
              end
            end

            # Enterprise only. Edit several segments' translations for a language target in one atomic request: every edit applies or none does. Bumps the target's `revision` and marks it `stale` if it had already completed. The source transcript and the project's other languages are untouched, and no audio changes until you regenerate the target.
            def update_segments(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request_body = ::Elevenlabs::Dubbing::Project::Language::Transcript::Types::DubbingBulkTargetSegmentUpdateRequest.new(params.except(:project_id, :language_id))
              request_body.validate! if request_body.respond_to?(:validate!)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'PATCH',
                path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language/#{URI.encode_uri_component(params[:language_id].to_s)}/transcript/segments",
                body: request_body.to_h,
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingBulkTargetSegmentUpdateResponse.load(body) }
                result.validate! if result.respond_to?(:validate!)
                result
              else
                error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
                error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
                raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
              end
            end

            # Enterprise only. Re-dub a target from its edited transcript, re-synthesizing only the edited regions (charged like a generation, less the free-regeneration allowance). Accepted asynchronously: the target returns to `processing` and sends a `dubbing_language_completed` event to the project's `webhook_ids` when the re-dub lands, carrying the new output URLs. Returns a conflict when the target has no edits to apply — nothing is dispatched and nothing is charged.
            def regenerate(request_options: {}, **params)
              params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
              request = ::Elevenlabs::Internal::JSON::Request.new(
                base_url: request_options[:base_url],
                method: 'POST',
                path: "v1/dubbing/project/#{URI.encode_uri_component(params[:project_id].to_s)}/language/#{URI.encode_uri_component(params[:language_id].to_s)}/transcript/regenerate",
                request_options: request_options,
              )
              response = @client.send(request)
              code = response.code.to_i
              if code.between?(200, 299)
                result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DubbingRegenerateResponse.load(body) }
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
end
