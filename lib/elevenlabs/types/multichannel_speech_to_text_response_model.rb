# frozen_string_literal: true

module Elevenlabs
  module Types
    class MultichannelSpeechToTextResponseModel < ::Elevenlabs::Internal::Types::Model
      field :transcripts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SpeechToTextChunkResponseModel] }, optional: false, nullable: false
      field :transcription_id, -> { String }, optional: true, nullable: true
      field :audio_duration_secs, -> { Float }, optional: true, nullable: true

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
