# frozen_string_literal: true

module Elevenlabs
  module Types
    class TriggeredGuardrailCommonModel < ::Elevenlabs::Internal::Types::Model
      field :guardrail_type, -> { ::Elevenlabs::Types::GuardrailType }, optional: false, nullable: false
      field :guardrail_name, -> { String }, optional: true, nullable: true
      field :execution_mode, -> { ::Elevenlabs::Types::GuardrailExecutionMode }, optional: true, nullable: false
      field :guardrail_details, -> { ::Elevenlabs::Types::TriggeredGuardrailCommonModelGuardrailDetails }, optional: true, nullable: true

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
