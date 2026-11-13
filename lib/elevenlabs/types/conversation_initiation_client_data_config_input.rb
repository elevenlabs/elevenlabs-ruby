# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataConfigInput < ::Elevenlabs::Internal::Types::Model
      field :conversation_config_override, -> { ::Elevenlabs::Types::ConversationConfigClientOverrideConfigInput }, optional: true, nullable: false
      field :custom_llm_extra_body, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_conversation_initiation_client_data_from_webhook, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_starting_workflow_node_id_from_client, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :enable_procedure_ids_from_client, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
