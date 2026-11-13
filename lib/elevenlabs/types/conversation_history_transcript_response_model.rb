# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryTranscriptResponseModel < ::Elevenlabs::Internal::Types::Model
      field :role, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptResponseModelRole }, optional: false, nullable: false
      field :agent_metadata, -> { ::Elevenlabs::Types::AgentMetadata }, optional: true, nullable: false
      field :message, -> { String }, optional: true, nullable: true
      field :multivoice_message, -> { ::Elevenlabs::Types::ConversationHistoryMultivoiceMessageModel }, optional: true, nullable: false
      field :tool_calls, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptToolCallCommonModelOutput] }, optional: true, nullable: false
      field :tool_results, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptResponseModelToolResultsItem] }, optional: true, nullable: false
      field :feedback, -> { ::Elevenlabs::Types::UserFeedback }, optional: true, nullable: false
      field :llm_override, -> { String }, optional: true, nullable: true
      field :producing_llm, -> { String }, optional: true, nullable: true
      field :time_in_call_secs, -> { Integer }, optional: false, nullable: false
      field :conversation_turn_metrics, -> { ::Elevenlabs::Types::ConversationTurnMetrics }, optional: true, nullable: false
      field :rag_retrieval_info, -> { ::Elevenlabs::Types::RagRetrievalInfo }, optional: true, nullable: false
      field :llm_usage, -> { ::Elevenlabs::Types::LlmUsageOutput }, optional: true, nullable: false
      field :interrupted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :ignored_as_backchannel, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :platform_event, -> { ::Elevenlabs::Types::TranscriptPlatformEvent }, optional: true, nullable: false
      field :original_message, -> { String }, optional: true, nullable: true
      field :reasoning, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationReasoningModel] }, optional: true, nullable: false
      field :source_medium, -> { ::Elevenlabs::Types::ChatSourceMedium }, optional: true, nullable: false
      field :source_event_id, -> { Integer }, optional: true, nullable: true
      field :used_static_kb_document_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :user_identifier, -> { String }, optional: true, nullable: true
      field :id, -> { String }, optional: true, nullable: true
      field :created_at_unix_ms, -> { Integer }, optional: true, nullable: true
      field :triggered_guardrails, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TriggeredGuardrailCommonModel] }, optional: true, nullable: false
      field :file_input, -> { ::Elevenlabs::Types::ConversationHistoryTranscriptFileInputResponseModel }, optional: true, nullable: true
      field :file_inputs, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptFileInputResponseModel] }, optional: true, nullable: false
      field :contextual_update_info, -> { ::Elevenlabs::Types::ContextualUpdateInfo }, optional: true, nullable: true
      field :reasoned, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
