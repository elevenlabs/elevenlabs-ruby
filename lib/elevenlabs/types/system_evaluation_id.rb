# frozen_string_literal: true

module Elevenlabs
  module Types
    module SystemEvaluationID
      extend ::Elevenlabs::Internal::Types::Enum

      V_SYSTEM_EVAL_CRITERIA_SENTIMENT = :__system_eval_criteria_sentiment
      V_SYSTEM_EVAL_CRITERIA_FRUSTRATION = :__system_eval_criteria_frustration

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
