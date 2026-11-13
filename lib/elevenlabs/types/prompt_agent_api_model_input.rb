# frozen_string_literal: true

module Elevenlabs
  module Types
    class PromptAgentAPIModelInput < ::Elevenlabs::Internal::Types::Model
      field :prompt, -> { String }, optional: true, nullable: false
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :reasoning_effort, -> { ::Elevenlabs::Types::LlmReasoningEffort }, optional: true, nullable: false
      field :service_tier, -> { ::Elevenlabs::Types::LlmServiceTier }, optional: true, nullable: false
      field :thinking_budget, -> { Integer }, optional: true, nullable: true
      field :enable_reasoning_summary, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :temperature, -> { Float }, optional: true, nullable: true
      field :max_tokens, -> { Integer }, optional: true, nullable: false
      field :tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :tool_ids_strict, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :built_in_tools, -> { ::Elevenlabs::Types::BuiltInToolsInput }, optional: true, nullable: false
      field :enable_parallel_tool_calls, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :native_mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :knowledge_base, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseLocator] }, optional: true, nullable: false
      field :custom_llm, -> { ::Elevenlabs::Types::CustomLlm }, optional: true, nullable: true
      field :ignore_default_personality, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :rag, -> { ::Elevenlabs::Types::RagConfigInput }, optional: true, nullable: false
      field :timezone, -> { String }, optional: true, nullable: true
      field :backup_llm_config, -> { ::Elevenlabs::Types::PromptAgentAPIModelInputBackupLlmConfig }, optional: true, nullable: false
      field :cascade_timeout_seconds, -> { Float }, optional: true, nullable: false
      field :tools, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::PromptAgentAPIModelInputToolsItem] }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(mcp_server_ids, 'mcp_server_ids', max_items: 10)
        ::Elevenlabs::Validator.validate_array!(native_mcp_server_ids, 'native_mcp_server_ids', max_items: 10)
        Validator.validate_number!(cascade_timeout_seconds, 'cascade_timeout_seconds', min: 2, max: 15)
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
