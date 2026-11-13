# frozen_string_literal: true

module Elevenlabs
  module Types
    class MergePreviewResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agent_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :conversation_config, -> { ::Elevenlabs::Types::ConversationalConfig }, optional: false, nullable: false
      field :metadata, -> { ::Elevenlabs::Types::AgentMetadataResponseModel }, optional: false, nullable: false
      field :platform_settings, -> { ::Elevenlabs::Types::AgentPlatformSettingsResponseModel }, optional: true, nullable: false
      field :phone_numbers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::MergePreviewResponseModelPhoneNumbersItem] }, optional: true, nullable: false
      field :whatsapp_accounts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::GetWhatsAppAccountResponse] }, optional: true, nullable: false
      field :workflow, -> { ::Elevenlabs::Types::AgentWorkflowResponseModel }, optional: true, nullable: false
      field :access_info, -> { ::Elevenlabs::Types::ResourceAccessInfo }, optional: true, nullable: false
      field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :version_id, -> { String }, optional: true, nullable: true
      field :branch_id, -> { String }, optional: true, nullable: true
      field :main_branch_id, -> { String }, optional: true, nullable: true
      field :procedures, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::ProcedureRefResponseModel] }, optional: true, nullable: false
      field :default_hold_audio_url, -> { String }, optional: true, nullable: false
      field :overridden_fields, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :conflicts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::FieldConflict] }, optional: true, nullable: false
      field :source_identical_to_target, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
