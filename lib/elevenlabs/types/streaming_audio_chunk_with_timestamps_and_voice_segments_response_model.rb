# frozen_string_literal: true

module Elevenlabs
  module Types
    class StreamingAudioChunkWithTimestampsAndVoiceSegmentsResponseModel < ::Elevenlabs::Internal::Types::Model
      field :audio_base64, -> { String }, optional: false, nullable: false
      field :alignment, -> { ::Elevenlabs::Types::CharacterAlignmentResponseModel }, optional: true, nullable: false
      field :normalized_alignment, -> { ::Elevenlabs::Types::CharacterAlignmentResponseModel }, optional: true, nullable: false
      field :voice_segments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VoiceSegment] }, optional: false, nullable: false

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
