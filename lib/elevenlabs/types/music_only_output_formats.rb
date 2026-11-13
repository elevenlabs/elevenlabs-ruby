# frozen_string_literal: true

module Elevenlabs
  module Types
    module MusicOnlyOutputFormats
      extend ::Elevenlabs::Internal::Types::Enum

      MP3_48000_128 = :mp3_48000_128
      MP3_48000_192 = :mp3_48000_192
      MP3_48000_240 = :mp3_48000_240
      MP3_48000_320 = :mp3_48000_320

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
