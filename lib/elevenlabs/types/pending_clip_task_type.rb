# frozen_string_literal: true

module Elevenlabs
  module Types
    module PendingClipTaskType
      extend ::Elevenlabs::Internal::Types::Enum

      PREPROCESSING = :preprocessing
      SPEECH_IMPORT = :speech_import
      DUBBING = :dubbing
      VIDEO_TO_MUSIC = :video_to_music
      MEDIA_GENERATION = :media_generation

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
