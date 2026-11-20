# frozen_string_literal: true

module Elevenlabs
  module Types
    class TimeRangeModel < ::Elevenlabs::Internal::Types::Model
      field :start_hour, -> { Integer }, optional: false, nullable: false
      field :start_minute, -> { Integer }, optional: false, nullable: false
      field :end_hour, -> { Integer }, optional: false, nullable: false
      field :end_minute, -> { Integer }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(start_hour, 'start_hour', min: 0)
        ::Elevenlabs::Validator.validate_integer!(start_minute, 'start_minute', min: 0)
        ::Elevenlabs::Validator.validate_integer!(end_hour, 'end_hour', min: 0, max: 24)
        ::Elevenlabs::Validator.validate_integer!(end_minute, 'end_minute', min: 0)
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
