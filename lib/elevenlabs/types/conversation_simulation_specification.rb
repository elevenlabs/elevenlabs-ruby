# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConversationSimulationSpecification < ::Elevenlabs::Internal::Types::Model
      field :simulated_user_config, -> { ::Elevenlabs::Types::AgentConfig }, optional: false, nullable: false
      field :tool_mock_config, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::ToolMockConfig] }, optional: true, nullable: false
      field :partial_conversation_history, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ConversationHistoryTranscriptCommonModelInput] }, optional: true, nullable: false
      field :dynamic_variables, -> { Object }, optional: true, nullable: false

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
