# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryAnalysisCommonModel < ::Elevenlabs::Internal::Types::Model
      field :evaluation_criteria_results, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::ConversationHistoryEvaluationCriteriaResultCommonModel] }, optional: true, nullable: false
      field :data_collection_results, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::DataCollectionResultCommonModel] }, optional: true, nullable: false
      field :evaluation_criteria_results_list, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryEvaluationCriteriaResultCommonModel] }, optional: true, nullable: false
      field :data_collection_results_list, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DataCollectionResultCommonModel] }, optional: true, nullable: false
      field :call_successful, -> { ::Elevenlabs::Types::EvaluationSuccessResult }, optional: false, nullable: false
      field :call_success_score, -> { Float }, optional: true, nullable: true
      field :transcript_summary, -> { String }, optional: false, nullable: false
      field :call_summary_title, -> { String }, optional: true, nullable: true
      field :scoped, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ScopedAnalysisResult] }, optional: true, nullable: false

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
