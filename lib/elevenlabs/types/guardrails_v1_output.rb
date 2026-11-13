# frozen_string_literal: true

module Elevenlabs
  module Types
    class GuardrailsV1Output < ::Elevenlabs::Internal::Types::Model
      field :version, -> { ::Elevenlabs::Types::GuardrailsV1OutputVersion }, optional: true, nullable: false
      field :focus, -> { ::Elevenlabs::Types::FocusGuardrail }, optional: true, nullable: false
      field :prompt_injection, -> { ::Elevenlabs::Types::PromptInjectionGuardrail }, optional: true, nullable: false
      field :content, -> { ::Elevenlabs::Types::ContentGuardrailOutput }, optional: true, nullable: false
      field :custom, -> { ::Elevenlabs::Types::CustomGuardrailOutput }, optional: true, nullable: false

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
