# frozen_string_literal: true

module Elevenlabs
  module V1TranslationRealtime
    module Types
      module TranslationRealtimeTtsModelID
        extend ::Elevenlabs::Internal::Types::Enum

        ELEVEN_FLASH_V2_5 = :eleven_flash_v2_5
        ELEVEN_V3 = :eleven_v3
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
end
