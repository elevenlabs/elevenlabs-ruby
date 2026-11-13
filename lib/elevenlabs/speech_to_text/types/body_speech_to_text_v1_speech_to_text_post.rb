# frozen_string_literal: true

module Elevenlabs
  module SpeechToText
    module Types
      class BodySpeechToTextV1SpeechToTextPost < ::Elevenlabs::Internal::Types::Model
        field :model_id, -> { String }, optional: false, nullable: false
        field :file, -> { String }, optional: true, nullable: true
        field :language_code, -> { String }, optional: true, nullable: true
        field :secondary_language_codes, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
        field :numbers_format, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostNumbersFormat }, optional: true, nullable: true
        field :transcript_edit, -> { String }, optional: true, nullable: true
        field :tag_audio_events, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :num_speakers, -> { Integer }, optional: true, nullable: true
        field :timestamps_granularity, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostTimestampsGranularity }, optional: true, nullable: false
        field :diarize, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :diarization_threshold, -> { Float }, optional: true, nullable: true
        field :additional_formats, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ExportOptions] }, optional: true, nullable: false
        field :file_format, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostFileFormat }, optional: true, nullable: false
        field :source_url, -> { String }, optional: true, nullable: true
        field :webhook, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :webhook_id, -> { String }, optional: true, nullable: true
        field :temperature, -> { Float }, optional: true, nullable: true
        field :seed, -> { Integer }, optional: true, nullable: true
        field :use_multi_channel, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :multichannel_output_style, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostMultichannelOutputStyle }, optional: true, nullable: false
        field :webhook_metadata, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostWebhookMetadata }, optional: true, nullable: true
        field :entity_detection, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostEntityDetection }, optional: true, nullable: true
        field :no_verbatim, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :use_speaker_library, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :detect_speaker_roles, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
        field :entity_redaction, -> { ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPostEntityRedaction }, optional: true, nullable: true
        field :entity_redaction_mode, -> { String }, optional: true, nullable: false
        field :keyterms, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

        def validate!
          ::Elevenlabs::Validator.validate_integer!(num_speakers, 'num_speakers', min: 1, max: 32)
          Validator.validate_number!(diarization_threshold, 'diarization_threshold', min: 0.1, max: 0.4)
          ::Elevenlabs::Validator.validate_array!(additional_formats, 'additional_formats', max_items: 10)
          Validator.validate_number!(temperature, 'temperature', min: 0, max: 2)
          ::Elevenlabs::Validator.validate_integer!(seed, 'seed', min: 0, max: 2_147_483_647)
        end

        def self.load(str)
          coerce(::JSON.parse(str, symbolize_names: true))
        end

        def self.dump(value)
          coerced = coerce(value)
          ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
        end
      end
    end
  end
end
