# frozen_string_literal: true

module Elevenlabs
  module Types
    class UserEvaluationAnalysisItem < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :source, -> { ::Elevenlabs::Types::UserEvaluationAnalysisItemSource }, optional: true, nullable: false
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :kind, -> { ::Elevenlabs::Types::UserEvaluationAnalysisItemKind }, optional: true, nullable: false
      field :conversation_goal_prompt, -> { String }, optional: false, nullable: false
      field :use_knowledge_base, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :scoring, -> { ::Elevenlabs::Types::UserEvaluationAnalysisItemScoring }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(conversation_goal_prompt, 'conversation_goal_prompt', max_length: 2000)
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
