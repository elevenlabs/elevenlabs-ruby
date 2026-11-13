# frozen_string_literal: true

module Elevenlabs
  module Types
    class RetryPolicy < ::Elevenlabs::Internal::Types::Model
      field :retry_delay_seconds, -> { Integer }, optional: true, nullable: false
      field :max_short_retries, -> { Integer }, optional: true, nullable: false
      field :max_total_calls, -> { Integer }, optional: true, nullable: false
      field :max_callbacks, -> { Integer }, optional: true, nullable: false
      field :max_redirects, -> { Integer }, optional: true, nullable: false
      field :interval_placement, -> { ::Elevenlabs::Types::IntervalPlacement }, optional: true, nullable: false
      field :rotate_step_seconds, -> { Integer }, optional: true, nullable: false
      field :max_consecutive_failures_per_number, -> { Integer }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(max_short_retries, 'max_short_retries', min: 0, max: 30)
        ::Elevenlabs::Validator.validate_integer!(max_total_calls, 'max_total_calls', min: 1, max: 30)
        ::Elevenlabs::Validator.validate_integer!(max_callbacks, 'max_callbacks', min: 0, max: 30)
        ::Elevenlabs::Validator.validate_integer!(max_redirects, 'max_redirects', min: 0, max: 30)
        ::Elevenlabs::Validator.validate_integer!(max_consecutive_failures_per_number, 'max_consecutive_failures_per_number', min: 1, max: 30)
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
