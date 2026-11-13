# frozen_string_literal: true

module Elevenlabs
  module Types
    class ContentConfig < ::Elevenlabs::Internal::Types::Model
      field :sexual, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false
      field :violence, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false
      field :harassment, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false
      field :self_harm, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false
      field :profanity, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false
      field :religion_or_politics, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false
      field :medical_and_legal_information, -> { ::Elevenlabs::Types::ContentThresholdGuardrail }, optional: true, nullable: false

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
