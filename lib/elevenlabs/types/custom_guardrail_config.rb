# frozen_string_literal: true

module Elevenlabs
  module Types
    class CustomGuardrailConfig < ::Elevenlabs::Internal::Types::Model
      field :is_enabled, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false
      field :execution_mode, -> { ::Elevenlabs::Types::GuardrailExecutionMode }, optional: true, nullable: false
      field :model, -> { ::Elevenlabs::Types::CustomGuardrailConfigModel }, optional: true, nullable: false
      field :history_message_count, -> { Integer }, optional: true, nullable: false
      field :trigger_action, -> { ::Elevenlabs::Types::CustomGuardrailConfigTriggerAction }, optional: true, nullable: false
      field :evaluate_full_response_only, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1, max_length: 500)
        ::Elevenlabs::Validator.validate_string!(prompt, 'prompt', min_length: 1, max_length: 10_000)
        ::Elevenlabs::Validator.validate_integer!(history_message_count, 'history_message_count', min: 0, max: 100)
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
