# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetConversationResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :agent_name, -> { String }, optional: true, nullable: true
      field :conversation_product, -> { String }, optional: true, nullable: false
      field :status, -> { ::Elevenlabs::Types::GetConversationResponseModelStatus }, optional: false, nullable: false
      field :user_id, -> { String }, optional: true, nullable: true
      field :branch_id, -> { String }, optional: true, nullable: true
      field :version_id, -> { String }, optional: true, nullable: true
      field :metadata, -> { ::Elevenlabs::Types::ConversationHistoryMetadataCommonModel }, optional: false, nullable: false
      field :analysis, -> { ::Elevenlabs::Types::ConversationHistoryAnalysisCommonModel }, optional: true, nullable: true
      field :user_message_count, -> { Integer }, optional: true, nullable: true
      field :agent_message_count, -> { Integer }, optional: true, nullable: true
      field :visited_agents, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VisitedAgentRef] }, optional: true, nullable: false
      field :conversation_initiation_client_data, -> { ::Elevenlabs::Types::ConversationInitiationClientDataRequestOutput }, optional: true, nullable: false
      field :environment, -> { String }, optional: true, nullable: false
      field :conversation_id, -> { String }, optional: false, nullable: false
      field :has_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :has_user_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :has_response_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :has_auxiliary_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :transcript, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptResponseModel] }, optional: false, nullable: false
      field :tag_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :otlp_traces, -> { Object }, optional: true, nullable: true

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
