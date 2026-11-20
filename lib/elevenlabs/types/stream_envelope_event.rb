# frozen_string_literal: true

module Elevenlabs
  module Types
    module StreamEnvelopeEvent
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::AgentChatResponsePartClientEvent }, key: 'agent_chat_response_part'
      member -> { ::Elevenlabs::Types::AgentReasoningResponsePartClientEvent }, key: 'agent_reasoning_response_part'
      member -> { ::Elevenlabs::Types::AgentResponseClientEvent }, key: 'agent_response'
      member -> { ::Elevenlabs::Types::AgentToolRequestStreamedEvent }, key: 'agent_tool_request'
      member -> { ::Elevenlabs::Types::AgentToolResponseStreamedEvent }, key: 'agent_tool_response'
      member -> { ::Elevenlabs::Types::ClientToolCallEvent }, key: 'client_tool_call'
      member -> { ::Elevenlabs::Types::StreamEndedEvent }, key: 'stream_ended'

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
