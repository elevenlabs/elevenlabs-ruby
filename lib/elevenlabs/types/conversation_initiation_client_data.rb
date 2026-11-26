# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientData < ::Elevenlabs::Internal::Types::Model
      field :conversation_config_override, -> { ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverride }, optional: true, nullable: false
      field :custom_llm_extra_body, -> { Object }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
      field :source_info, -> { ::Elevenlabs::Types::ConversationInitiationClientDataSourceInfo }, optional: true, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: false
      field :environment, -> { String }, optional: true, nullable: false
      field :starting_workflow_node_id, -> { String }, optional: true, nullable: false
      field :procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :start_procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :dynamic_variables, -> { Object }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ConversationInitiationClientDataType }, optional: true, nullable: false

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
