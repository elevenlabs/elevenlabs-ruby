# frozen_string_literal: true

module Elevenlabs
  module Types
    module InlineBase64ReferenceMimeType
      extend ::Elevenlabs::Internal::Types::Enum

      IMAGE_JPEG = :'image/jpeg'
      IMAGE_PNG = :'image/png'
      IMAGE_WEBP = :'image/webp'
      IMAGE_HEIC = :'image/heic'
      IMAGE_HEIF = :'image/heif'
      AUDIO_MPEG = :'audio/mpeg'
      AUDIO_WAV = :'audio/wav'
      VIDEO_MP4 = :'video/mp4'
      VIDEO_QUICKTIME = :'video/quicktime'
      VIDEO_WEBM = :'video/webm'

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
