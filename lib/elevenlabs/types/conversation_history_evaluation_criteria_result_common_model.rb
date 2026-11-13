# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryEvaluationCriteriaResultCommonModel < ::Elevenlabs::Internal::Types::Model
      field :criteria_id, -> { String }, optional: false, nullable: false
      field :result, -> { ::Elevenlabs::Types::EvaluationSuccessResult }, optional: false, nullable: false
      field :rationale, -> { String }, optional: false, nullable: false
      field :scoring_mode, -> { ::Elevenlabs::Types::CriteriaScoringMode }, optional: true, nullable: false
      field :score, -> { Integer }, optional: true, nullable: true
      field :max_score, -> { Integer }, optional: true, nullable: true

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
