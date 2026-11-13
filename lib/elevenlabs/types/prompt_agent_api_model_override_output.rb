# frozen_string_literal: true

module Elevenlabs
  module Types
    class PromptAgentAPIModelOverrideOutput < ::Elevenlabs::Internal::Types::Model
      field :prompt, -> { String }, optional: true, nullable: true
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :reasoning_effort, -> { ::Elevenlabs::Types::LlmReasoningEffort }, optional: true, nullable: false
      field :tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :tool_ids_strict, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :native_mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :knowledge_base, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseLocator] }, optional: true, nullable: true

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
