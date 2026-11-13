# frozen_string_literal: true

module Elevenlabs
  module Types
    module BackgroundSoundPresetID
      extend ::Elevenlabs::Internal::Types::Enum

      OFFICE2 = :office2
      OFFICE1 = :office1
      RESTAURANT = :restaurant
      CITY = :city
      TYPING = :typing
      ELEVATOR1 = :elevator1
      ELEVATOR2 = :elevator2
      ELEVATOR3 = :elevator3
      ELEVATOR4 = :elevator4

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
