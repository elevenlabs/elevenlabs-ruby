# frozen_string_literal: true

module Elevenlabs
  module Types
    module MusicGenerationMode
      extend ::Elevenlabs::Internal::Types::Enum

      TRACK = :track
      LOOP = :loop
      AMBIENCE = :ambience
      VIDEO_TO_MUSIC = :video_to_music

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
