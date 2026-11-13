# frozen_string_literal: true

module Elevenlabs
  module Types
    module InlineImageReferenceMimeType
      extend ::Elevenlabs::Internal::Types::Enum

      IMAGE_JPEG = :'image/jpeg'
      IMAGE_PNG = :'image/png'
      IMAGE_WEBP = :'image/webp'
      IMAGE_HEIC = :'image/heic'
      IMAGE_HEIF = :'image/heif'

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
