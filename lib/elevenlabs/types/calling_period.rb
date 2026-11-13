# frozen_string_literal: true

module Elevenlabs
  module Types
    class CallingPeriod < ::Elevenlabs::Internal::Types::Model
      field :weekdays, -> { ::Elevenlabs::Internal::Types::Array[Integer] }, optional: false, nullable: false
      field :intervals, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::CallingIntervalPolicy] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(weekdays, 'weekdays', min_items: 1)
        ::Elevenlabs::Validator.validate_array!(intervals, 'intervals', min_items: 1)
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
