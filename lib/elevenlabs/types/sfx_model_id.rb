# frozen_string_literal: true

module Elevenlabs
  module Types
    module SfxModelID
      extend ::Elevenlabs::Internal::Types::Enum

      ELEVEN_TEXT_TO_SOUND_V2 = :eleven_text_to_sound_v2
      ELEVEN_TEXT_TO_SOUND_V3 = :eleven_text_to_sound_v3

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
