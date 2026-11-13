# frozen_string_literal: true

require 'uri'

module Elevenlabs
  module Voices
    module Pvc
      module Samples
        class Client
          def initialize(client:)
            @client = client
          end

          # Add audio samples to a PVC voice
          def create(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            body = ::Elevenlabs::Internal::Multipart::FormData.new
            params[:files]&.each { |item| body.add_file(name: 'files', file: item) }
            body.add(name: 'remove_background_noise', value: params[:remove_background_noise]) if params.key?(:remove_background_noise)
            request = ::Elevenlabs::Internal::Multipart::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/samples",
              body: body,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VoiceSample].coerce(::JSON.parse(body, symbolize_names: false)) }
              result&.each { |item| item.validate! if item.respond_to?(:validate!) }
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Update a PVC voice sample - apply noise removal, select speaker, change trim times or file name.
          def update(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request_body = ::Elevenlabs::Voices::Pvc::Samples::Types::BodyUpdatePvcVoiceSampleV1VoicesPvcVoiceIDSamplesSampleIDPost.new(params.except(:voice_id, :sample_id))
            request_body.validate! if request_body.respond_to?(:validate!)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'POST',
              path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/samples/#{URI.encode_uri_component(params[:sample_id].to_s)}",
              body: request_body.to_h,
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::AddVoiceResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          # Delete a sample from a PVC voice.
          def delete(request_options: {}, **params)
            params = ::Elevenlabs::Internal::Types::Utils.normalize_keys(params)
            request = ::Elevenlabs::Internal::JSON::Request.new(
              base_url: request_options[:base_url],
              method: 'DELETE',
              path: "v1/voices/pvc/#{URI.encode_uri_component(params[:voice_id].to_s)}/samples/#{URI.encode_uri_component(params[:sample_id].to_s)}",
              request_options: request_options,
            )
            response = @client.send(request)
            code = response.code.to_i
            if code.between?(200, 299)
              result = ::Elevenlabs::Internal::Http::ResponseBody.decode(response) { |body| ::Elevenlabs::Types::DeleteVoiceSampleResponseModel.load(body) }
              result.validate! if result.respond_to?(:validate!)
              result
            else
              error_class = ::Elevenlabs::Errors::ResponseError.subclass_for_code(code)
              error_body = ::Elevenlabs::Errors::ResponseError.load_body(response.body, { 422 => ::Elevenlabs::Types::HTTPValidationError }[code])
              raise error_class.new(response.body, code: code, body: error_body, headers: response.to_hash)
            end
          end

          def audio
            @audio ||= Audio::Client.new(client: @client)
          end

          def waveform
            @waveform ||= Waveform::Client.new(client: @client)
          end

          def speakers
            @speakers ||= Speakers::Client.new(client: @client)
          end
        end
      end
    end
  end
end
