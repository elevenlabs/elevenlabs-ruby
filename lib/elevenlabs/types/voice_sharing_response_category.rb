# frozen_string_literal: true

module Elevenlabs
  module Types
    module VoiceSharingResponseCategory
      extend ::Elevenlabs::Internal::Types::Enum

      GENERATED = :generated
      CLONED = :cloned
      PREMADE = :premade
      PROFESSIONAL = :professional
      FAMOUS = :famous
      HIGH_QUALITY = :high_quality

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
