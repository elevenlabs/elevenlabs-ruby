# frozen_string_literal: true

module Elevenlabs
  module Types
    class OpenAiAudioInputConfigInput < ::Elevenlabs::Internal::Types::Model
      field :format, -> { ::Elevenlabs::Types::OpenAiAudioInputFormat }, optional: true, nullable: false
      field :transcription, -> { ::Elevenlabs::Types::OpenAiAudioInputTranscription }, optional: true, nullable: true
      field :turn_detection, -> { ::Elevenlabs::Types::OpenAiTurnDetection }, optional: true, nullable: true
      field :pacing, -> { ::Elevenlabs::Types::AudioInputPacing }, optional: true, nullable: false

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
