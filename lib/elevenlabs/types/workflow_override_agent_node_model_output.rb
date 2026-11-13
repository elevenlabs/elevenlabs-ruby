# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowOverrideAgentNodeModelOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowOverrideAgentNodeModelOutputType }, optional: false, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionOutput }, optional: false, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :conversation_config, -> { ::Elevenlabs::Types::ConversationalConfigAPIModelWorkflowOverrideOutput }, optional: false, nullable: false
      field :additional_prompt, -> { String }, optional: false, nullable: false
      field :additional_knowledge_base, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseLocator] }, optional: false, nullable: false
      field :additional_tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :entry_behavior, -> { ::Elevenlabs::Types::EntryBehavior }, optional: false, nullable: false

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
