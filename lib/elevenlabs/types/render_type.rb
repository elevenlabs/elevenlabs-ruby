# frozen_string_literal: true

module Elevenlabs
  module Types
    module RenderType
      extend ::Elevenlabs::Internal::Types::Enum

      MP4 = :mp4
      AAC = :aac
      MP3 = :mp3
      WAV = :wav
      AAF = :aaf
      TRACKS_ZIP = :tracks_zip
      CLIPS_ZIP = :clips_zip
      ZIP = :zip

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
