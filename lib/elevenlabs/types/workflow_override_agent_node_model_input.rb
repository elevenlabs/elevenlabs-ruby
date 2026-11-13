# frozen_string_literal: true

module Elevenlabs
  module Types
    class WorkflowOverrideAgentNodeModelInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WorkflowOverrideAgentNodeModelInputType }, optional: true, nullable: false
      field :position, -> { ::Elevenlabs::Types::PositionInput }, optional: true, nullable: false
      field :edge_order, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :conversation_config, -> { ::Elevenlabs::Types::ConversationalConfigAPIModelWorkflowOverrideInput }, optional: true, nullable: false
      field :additional_prompt, -> { String }, optional: true, nullable: false
      field :additional_knowledge_base, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseLocator] }, optional: true, nullable: false
      field :additional_tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :label, -> { String }, optional: false, nullable: false
      field :entry_behavior, -> { ::Elevenlabs::Types::EntryBehavior }, optional: true, nullable: false

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
