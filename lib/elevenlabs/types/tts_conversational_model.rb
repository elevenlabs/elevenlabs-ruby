# frozen_string_literal: true

module Elevenlabs
  module Types
    module TtsConversationalModel
      extend ::Elevenlabs::Internal::Types::Enum

      ELEVEN_TURBO_V2 = :eleven_turbo_v2
      ELEVEN_TURBO_V2_5 = :eleven_turbo_v2_5
      ELEVEN_FLASH_V2 = :eleven_flash_v2
      ELEVEN_FLASH_V2_5 = :eleven_flash_v2_5
      ELEVEN_MULTILINGUAL_V2 = :eleven_multilingual_v2
      ELEVEN_V3_CONVERSATIONAL = :eleven_v3_conversational
      ELEVEN_V4 = :eleven_v4
      ELEVEN_V4_TURBO = :eleven_v4_turbo

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
