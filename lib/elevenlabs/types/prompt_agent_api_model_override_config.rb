# frozen_string_literal: true

module Elevenlabs
  module Types
    class PromptAgentAPIModelOverrideConfig < ::Elevenlabs::Internal::Types::Model
      field :prompt, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :llm, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :reasoning_effort, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tool_ids, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :tool_ids_strict, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :native_mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :knowledge_base, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
