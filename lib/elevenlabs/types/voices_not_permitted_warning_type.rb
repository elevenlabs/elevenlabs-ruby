# frozen_string_literal: true

module Elevenlabs
  module Types
    module VoicesNotPermittedWarningType
      extend ::Elevenlabs::Internal::Types::Enum

      VOICES_NOT_PERMITTED = :voices_not_permitted

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
