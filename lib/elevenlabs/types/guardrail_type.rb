# frozen_string_literal: true

module Elevenlabs
  module Types
    module GuardrailType
      extend ::Elevenlabs::Internal::Types::Enum

      CUSTOM = :custom
      PROMPT_INJECTION = :prompt_injection
      SELF_HARM_INTENT = :self_harm_intent
      VIOLENCE_GRAPHIC = :violence_graphic
      SEXUAL = :sexual
      VIOLENCE = :violence
      HARASSMENT = :harassment
      SEXUAL_MINORS = :sexual_minors
      SELF_HARM = :self_harm
      SELF_HARM_INSTRUCTIONS = :self_harm_instructions
      HARASSMENT_THREATENING = :harassment_threatening
      HATE = :hate
      HATE_THREATENING = :hate_threatening
      PROFANITY = :profanity
      RELIGION_OR_POLITICS = :religion_or_politics
      MEDICAL_AND_LEGAL = :medical_and_legal
      GUARDRAIL = :guardrail

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
