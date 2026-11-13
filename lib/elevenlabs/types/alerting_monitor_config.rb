# frozen_string_literal: true

module Elevenlabs
  module Types
    class AlertingMonitorConfig < ::Elevenlabs::Internal::Types::Model
      field :enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :threshold, -> { Float }, optional: true, nullable: true
      field :relative_increase_threshold, -> { Float }, optional: true, nullable: true
      field :min_failure_count, -> { Integer }, optional: true, nullable: true
      field :min_history_bucket_count, -> { Integer }, optional: true, nullable: true
      field :min_sample_count, -> { Integer }, optional: true, nullable: true
      field :suspect_trigger_threshold, -> { Integer }, optional: true, nullable: true
      field :auto_resolve_after_inactive_minutes, -> { Integer }, optional: true, nullable: true

      def validate!
        Validator.validate_number!(threshold, 'threshold', min: 0, max: 1)
        Validator.validate_number!(relative_increase_threshold, 'relative_increase_threshold', min: 0, max: 10)
        ::Elevenlabs::Validator.validate_integer!(min_failure_count, 'min_failure_count', min: 1)
        ::Elevenlabs::Validator.validate_integer!(min_history_bucket_count, 'min_history_bucket_count', min: 1)
        ::Elevenlabs::Validator.validate_integer!(min_sample_count, 'min_sample_count', min: 1)
        ::Elevenlabs::Validator.validate_integer!(suspect_trigger_threshold, 'suspect_trigger_threshold', min: 1, max: 10)
        ::Elevenlabs::Validator.validate_integer!(auto_resolve_after_inactive_minutes, 'auto_resolve_after_inactive_minutes', min: 1)
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
