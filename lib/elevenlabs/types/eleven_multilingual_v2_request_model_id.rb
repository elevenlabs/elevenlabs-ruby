# frozen_string_literal: true

module Elevenlabs
  module Types
    module ElevenMultilingualV2RequestModelID
      extend ::Elevenlabs::Internal::Types::Enum

      ELEVEN_MULTILINGUAL_V2 = :eleven_multilingual_v2

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
