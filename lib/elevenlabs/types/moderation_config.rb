# frozen_string_literal: true

module Elevenlabs
  module Types
    class ModerationConfig < ::Elevenlabs::Internal::Types::Model
      field :sexual, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :violence, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :violence_graphic, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :harassment, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :harassment_threatening, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :hate, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :hate_threatening, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :self_harm_instructions, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :self_harm, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :self_harm_intent, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false
      field :sexual_minors, -> { ::Elevenlabs::Types::ThresholdGuardrail }, optional: true, nullable: false

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
