# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationSummaryResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: true
      field :version_id, -> { String }, optional: true, nullable: true
      field :agent_name, -> { String }, optional: true, nullable: true
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :start_time_unix_secs, -> { Integer }, optional: false, nullable: false
      field :call_duration_secs, -> { Integer }, optional: false, nullable: false
      field :cost, -> { Integer }, optional: true, nullable: true
      field :cost_fiat, -> { Float }, optional: true, nullable: true
      field :message_count, -> { Integer }, optional: false, nullable: false
      field :user_message_count, -> { Integer }, optional: true, nullable: true
      field :agent_message_count, -> { Integer }, optional: true, nullable: true
      field :status, -> { ::Elevenlabs::Types::ConversationSummaryResponseModelStatus }, optional: false, nullable: false
      field :termination_reason, -> { String }, optional: true, nullable: false
      field :call_successful, -> { ::Elevenlabs::Types::EvaluationSuccessResult }, optional: false, nullable: false
      field :call_success_score, -> { Float }, optional: true, nullable: true
      field :transcript_summary, -> { String }, optional: true, nullable: true
      field :call_summary_title, -> { String }, optional: true, nullable: true
      field :main_language, -> { String }, optional: true, nullable: true
      field :conversation_initiation_source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: false
      field :tool_names, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :direction, -> { ::Elevenlabs::Types::TelephonyDirection }, optional: true, nullable: false
      field :rating, -> { Float }, optional: true, nullable: true
      field :sentiment_analysis, -> { ::Elevenlabs::Types::ConversationSentimentAnalysis }, optional: true, nullable: true
      field :data_collection_results, -> { Object }, optional: true, nullable: true
      field :evaluation_criteria_results, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::EvaluationCriteriaSummaryResult] }, optional: true, nullable: true
      field :tag_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
