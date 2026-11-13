# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeechToTextChunkResponseModel < ::Elevenlabs::Internal::Types::Model
      field :language_code, -> { String }, optional: false, nullable: false
      field :language_probability, -> { Float }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :words, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SpeechToTextWordResponseModel] }, optional: false, nullable: false
      field :channel_index, -> { Integer }, optional: true, nullable: true
      field :additional_formats, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AdditionalFormatResponseModel] }, optional: true, nullable: true
      field :transcription_id, -> { String }, optional: true, nullable: true
      field :entities, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DetectedEntity] }, optional: true, nullable: true
      field :audio_duration_secs, -> { Float }, optional: true, nullable: true
      field :edited_transcript, -> { ::Elevenlabs::Types::SpeechToTextChunkResponseModelEditedTranscript }, optional: true, nullable: true

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
