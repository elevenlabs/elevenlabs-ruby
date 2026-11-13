# frozen_string_literal: true

module Elevenlabs
  module Types
    class SafetyEvaluation < ::Elevenlabs::Internal::Types::Model
      field :is_unsafe, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :llm_reason, -> { String }, optional: true, nullable: false
      field :safety_prompt_version, -> { Integer }, optional: true, nullable: false
      field :matched_rule_id, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SafetyRule] }, optional: true, nullable: false

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
