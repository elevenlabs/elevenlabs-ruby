# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationInitiationClientDataInternal < ::Elevenlabs::Internal::Types::Model
      field :conversation_config_override, -> { ::Elevenlabs::Types::ConversationConfigClientOverrideOutput }, optional: true, nullable: false
      field :custom_llm_extra_body, -> { Object }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: true
      field :source_info, -> { ::Elevenlabs::Types::ConversationInitiationSourceInfo }, optional: true, nullable: false
      field :branch_id, -> { String }, optional: true, nullable: true
      field :environment, -> { String }, optional: true, nullable: true
      field :starting_workflow_node_id, -> { String }, optional: true, nullable: true
      field :procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :start_procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :dynamic_variables, -> { Object }, optional: true, nullable: false
      field :tool_mock_config, -> { ::Elevenlabs::Types::OrchestratorToolMockBehaviorConfig }, optional: true, nullable: false
      field :tool_mock_overrides, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ToolResponseMockConfigOutput]] }, optional: true, nullable: false

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
