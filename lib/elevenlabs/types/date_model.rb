# frozen_string_literal: true

module Elevenlabs
  module Types
    class DateModel < ::Elevenlabs::Internal::Types::Model
      field :year, -> { Integer }, optional: false, nullable: false
      field :month, -> { Integer }, optional: false, nullable: false
      field :day, -> { Integer }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(year, 'year', min: 2026, max: 2100)
        ::Elevenlabs::Validator.validate_integer!(month, 'month', min: 1, max: 12)
        ::Elevenlabs::Validator.validate_integer!(day, 'day', min: 1, max: 31)
      end

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
