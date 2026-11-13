# frozen_string_literal: true

module Elevenlabs
  module Types
    class ContentGuardrailOutput < ::Elevenlabs::Internal::Types::Model
      field :execution_mode, -> { ::Elevenlabs::Types::GuardrailExecutionMode }, optional: true, nullable: false
      field :config, -> { ::Elevenlabs::Types::ContentConfig }, optional: true, nullable: false
      field :trigger_action, -> { ::Elevenlabs::Types::ContentGuardrailOutputTriggerAction }, optional: true, nullable: false

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
