# frozen_string_literal: true

module Elevenlabs
  module Types
    class ScopedAnalysisResult < ::Elevenlabs::Internal::Types::Model
      field :scope, -> { ::Elevenlabs::Types::AnalysisScope }, optional: false, nullable: false
      field :source_agent_id, -> { String }, optional: false, nullable: false
      field :source_branch_id, -> { String }, optional: true, nullable: true
      field :evaluation_criteria_results, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::ConversationHistoryEvaluationCriteriaResultCommonModel] }, optional: true, nullable: false
      field :data_collection_results, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::DataCollectionResultCommonModel] }, optional: true, nullable: false
      field :successful, -> { ::Elevenlabs::Types::EvaluationSuccessResult }, optional: false, nullable: false
      field :success_score, -> { Float }, optional: true, nullable: true

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
