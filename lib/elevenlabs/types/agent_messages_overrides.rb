# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentMessagesOverrides < ::Elevenlabs::Internal::Types::Model
      field :prompt, -> { String }, optional: true, nullable: true
      field :llm, -> { ::Elevenlabs::Types::Llm }, optional: true, nullable: false
      field :language, -> { String }, optional: true, nullable: true
      field :tool_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :native_mcp_server_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :knowledge_base_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :procedure_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :custom_llm_extra_body, -> { Object }, optional: true, nullable: true

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
