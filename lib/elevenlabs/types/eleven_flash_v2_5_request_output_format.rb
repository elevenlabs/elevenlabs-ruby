# frozen_string_literal: true

module Elevenlabs
  module Types
    module ElevenFlashV25RequestOutputFormat
      extend ::Elevenlabs::Internal::Types::Enum

      MP3_22050_32 = :mp3_22050_32
      MP3_24000_48 = :mp3_24000_48
      MP3_44100_32 = :mp3_44100_32
      MP3_44100_64 = :mp3_44100_64
      MP3_44100_96 = :mp3_44100_96
      MP3_44100_128 = :mp3_44100_128
      MP3_44100_192 = :mp3_44100_192

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
