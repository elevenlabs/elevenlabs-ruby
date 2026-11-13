# frozen_string_literal: true

module Elevenlabs
  module Types
    class PromptAgentAPIModelWorkflowOverrideInput < ::Elevenlabs::Internal::Types::Model
      field :prompt, -> { String }, optional: true, nullable: true
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :reasoning_effort, -> { ::Elevenlabs::Types::LlmReasoningEffort }, optional: true, nullable: false
      field :service_tier, -> { ::Elevenlabs::Types::LlmServiceTier }, optional: true, nullable: false
      field :thinking_budget, -> { Integer }, optional: true, nullable: true
      field :enable_reasoning_summary, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :temperature, -> { Float }, optional: true, nullable: true
      field :max_tokens, -> { Integer }, optional: true, nullable: true
      field :tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :tool_ids_strict, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :built_in_tools, -> { ::Elevenlabs::Types::BuiltInToolsWorkflowOverrideInput }, optional: true, nullable: true
      field :enable_parallel_tool_calls, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :native_mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :knowledge_base, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseLocator] }, optional: true, nullable: true
      field :custom_llm, -> { ::Elevenlabs::Types::CustomLlm }, optional: true, nullable: false
      field :ignore_default_personality, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :rag, -> { ::Elevenlabs::Types::RagConfigWorkflowOverrideInput }, optional: true, nullable: true
      field :timezone, -> { String }, optional: true, nullable: true
      field :backup_llm_config, -> { ::Elevenlabs::Types::PromptAgentAPIModelWorkflowOverrideInputBackupLlmConfig }, optional: true, nullable: true
      field :cascade_timeout_seconds, -> { Float }, optional: true, nullable: true
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PromptAgentAPIModelWorkflowOverrideInputToolsItem] }, optional: true, nullable: true

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
