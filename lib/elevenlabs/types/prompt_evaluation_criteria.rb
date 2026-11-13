# frozen_string_literal: true

module Elevenlabs
  module Types
    class PromptEvaluationCriteria < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::PromptEvaluationCriteriaType }, optional: true, nullable: false
      field :conversation_goal_prompt, -> { String }, optional: false, nullable: false
      field :use_knowledge_base, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :scope, -> { ::Elevenlabs::Types::AnalysisScope }, optional: true, nullable: false
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :scoring_mode, -> { ::Elevenlabs::Types::CriteriaScoringMode }, optional: true, nullable: false
      field :max_score, -> { Integer }, optional: true, nullable: false
      field :score_instructions, -> { String }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(conversation_goal_prompt, 'conversation_goal_prompt', max_length: 2000)
        ::Elevenlabs::Validator.validate_string!(score_instructions, 'score_instructions', max_length: 2000)
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
