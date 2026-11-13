# frozen_string_literal: true

module Elevenlabs
  module Types
    module OutputFormat
      extend ::Elevenlabs::Internal::Types::Enum

      MP3_22050_32 = :mp3_22050_32
      MP3_44100_32 = :mp3_44100_32
      MP3_44100_64 = :mp3_44100_64
      MP3_44100_96 = :mp3_44100_96
      MP3_44100_128 = :mp3_44100_128
      MP3_44100_192 = :mp3_44100_192
      PCM_16000 = :pcm_16000
      PCM_22050 = :pcm_22050
      PCM_24000 = :pcm_24000
      PCM_44100 = :pcm_44100
      ULAW_8000 = :ulaw_8000

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
