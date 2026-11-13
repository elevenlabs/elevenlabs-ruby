# frozen_string_literal: true

module Elevenlabs
  module Types
    module Gemini25FlashImageRequestModelID
      extend ::Elevenlabs::Internal::Types::Enum

      GEMINI_2_5_FLASH_IMAGE = :'gemini-2.5-flash-image'

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
