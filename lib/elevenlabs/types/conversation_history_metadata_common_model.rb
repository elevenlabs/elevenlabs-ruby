# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationHistoryMetadataCommonModel < ::Elevenlabs::Internal::Types::Model
      field :start_time_unix_secs, -> { Integer }, optional: false, nullable: false
      field :accepted_time_unix_secs, -> { Integer }, optional: true, nullable: true
      field :call_duration_secs, -> { Integer }, optional: false, nullable: false
      field :queue_wait_secs, -> { Float }, optional: true, nullable: true
      field :cost, -> { Integer }, optional: true, nullable: true
      field :deletion_settings, -> { ::Elevenlabs::Types::ConversationDeletionSettings }, optional: true, nullable: false
      field :feedback, -> { ::Elevenlabs::Types::ConversationHistoryFeedbackCommonModel }, optional: true, nullable: false
      field :authorization_method, -> { ::Elevenlabs::Types::AuthorizationMethod }, optional: true, nullable: false
      field :charging, -> { ::Elevenlabs::Types::ConversationChargingCommonModel }, optional: true, nullable: false
      field :phone_call, -> { ::Elevenlabs::Types::ConversationHistoryMetadataCommonModelPhoneCall }, optional: true, nullable: true
      field :batch_call, -> { ::Elevenlabs::Types::ConversationHistoryBatchCallModel }, optional: true, nullable: true
      field :termination_reason, -> { String }, optional: true, nullable: false
      field :error, -> { ::Elevenlabs::Types::ConversationHistoryErrorCommonModel }, optional: true, nullable: true
      field :warnings, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :main_language, -> { String }, optional: true, nullable: true
      field :rag_usage, -> { ::Elevenlabs::Types::ConversationHistoryRagUsageCommonModel }, optional: true, nullable: true
      field :text_only, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :features_usage, -> { ::Elevenlabs::Types::FeaturesUsageCommonModel }, optional: true, nullable: false
      field :eleven_assistant, -> { ::Elevenlabs::Types::ConversationHistoryElevenAssistantCommonModel }, optional: true, nullable: false
      field :initiator_id, -> { String }, optional: true, nullable: true
      field :conversation_initiation_source, -> { ::Elevenlabs::Types::ConversationInitiationSource }, optional: true, nullable: false
      field :conversation_initiation_source_version, -> { String }, optional: true, nullable: true
      field :timezone, -> { String }, optional: true, nullable: true
      field :async_metadata, -> { ::Elevenlabs::Types::AsyncConversationMetadata }, optional: true, nullable: true
      field :whatsapp, -> { ::Elevenlabs::Types::WhatsAppConversationInfo }, optional: true, nullable: true
      field :sms, -> { ::Elevenlabs::Types::SmsConversationInfo }, optional: true, nullable: true
      field :agent_created_from, -> { ::Elevenlabs::Types::AgentDefinitionSource }, optional: true, nullable: false
      field :agent_last_updated_from, -> { ::Elevenlabs::Types::AgentDefinitionSource }, optional: true, nullable: false
      field :voice_rewards, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationVoiceRewardModel] }, optional: true, nullable: false
      field :cost_fiat, -> { Float }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(conversation_initiation_source_version, 'conversation_initiation_source_version', max_length: 50)
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
