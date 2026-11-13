# frozen_string_literal: true

module Elevenlabs
  module Types
    class AutoSyncInfo < ::Elevenlabs::Internal::Types::Model
      field :minimum_frequency_days, -> { Integer }, optional: true, nullable: false
      field :auto_remove, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :consec_failures, -> { Integer }, optional: true, nullable: false
      field :next_refresh_by, -> { Integer }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(minimum_frequency_days, 'minimum_frequency_days', min: 1, max: 180)
        ::Elevenlabs::Validator.validate_integer!(consec_failures, 'consec_failures', min: 0)
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
