# frozen_string_literal: true

module Elevenlabs
  module Types
    module SubscribeEvent
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Types::ConversationInitiationMetadata }
      member -> { ::Elevenlabs::Types::AgentResponseComplete }
      member -> { ::Elevenlabs::Types::ContextUsage }
      member -> { ::Elevenlabs::Types::McpToolCall }
      member -> { ::Elevenlabs::Types::ClientError }
      member -> { ::Elevenlabs::Types::GuardrailTriggered }
      member -> { ::Elevenlabs::Types::ConversationUserTranscript }
      member -> { ::Elevenlabs::Types::ConversationAgentResponse }
      member -> { ::Elevenlabs::Types::QueueStatus }
      member -> { ::Elevenlabs::Types::AgentResponseCorrection }
      member -> { ::Elevenlabs::Types::AgentResponseMetadata }
      member -> { ::Elevenlabs::Types::AudioResponse }
      member -> { ::Elevenlabs::Types::Interruption }
      member -> { ::Elevenlabs::Types::VadScore }
      member -> { ::Elevenlabs::Types::AgentChatResponsePart }
      member -> { ::Elevenlabs::Types::ClientToolCall }
      member -> { ::Elevenlabs::Types::AgentToolResponse }
      member -> { ::Elevenlabs::Types::AgentToolResponseFullPayload }
      member -> { ::Elevenlabs::Types::AgentToolRequest }
      member -> { ::Elevenlabs::Types::ConversationPing }
      member -> { ::Elevenlabs::Types::McpConnectionStatus }

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
