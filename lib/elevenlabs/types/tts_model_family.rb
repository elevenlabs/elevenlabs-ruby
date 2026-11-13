# frozen_string_literal: true

module Elevenlabs
  module Types
    module TtsModelFamily
      extend ::Elevenlabs::Internal::Types::Enum

      TURBO = :turbo
      FLASH = :flash
      MULTILINGUAL = :multilingual
      V3_CONVERSATIONAL = :v3_conversational
      V4 = :v4
      V4_TURBO = :v4_turbo

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
