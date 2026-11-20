# frozen_string_literal: true

module Elevenlabs
  module Types
    module FileInputMimeType
      extend ::Elevenlabs::Internal::Types::Enum

      IMAGE_PNG = :'image/png'
      IMAGE_JPEG = :'image/jpeg'
      IMAGE_GIF = :'image/gif'
      IMAGE_WEBP = :'image/webp'
      APPLICATION_PDF = :'application/pdf'
      TEXT_PLAIN = :'text/plain'

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
