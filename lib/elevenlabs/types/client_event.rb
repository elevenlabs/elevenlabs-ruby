# frozen_string_literal: true

module Elevenlabs
  module Types
    module ClientEvent
      extend ::Elevenlabs::Internal::Types::Enum

      CONVERSATION_INITIATION_METADATA = :conversation_initiation_metadata
      ASR_INITIATION_METADATA = :asr_initiation_metadata
      PING = :ping
      AUDIO = :audio
      INTERRUPTION = :interruption
      USER_TRANSCRIPT = :user_transcript
      TENTATIVE_USER_TRANSCRIPT = :tentative_user_transcript
      AGENT_RESPONSE = :agent_response
      AGENT_RESPONSE_CORRECTION = :agent_response_correction
      CLIENT_TOOL_CALL = :client_tool_call
      MCP_TOOL_CALL = :mcp_tool_call
      MCP_CONNECTION_STATUS = :mcp_connection_status
      AGENT_TOOL_REQUEST = :agent_tool_request
      AGENT_TOOL_RESPONSE = :agent_tool_response
      AGENT_TOOL_RESPONSE_FULL_PAYLOAD = :agent_tool_response_full_payload
      AGENT_RESPONSE_METADATA = :agent_response_metadata
      VAD_SCORE = :vad_score
      AGENT_CHAT_RESPONSE_PART = :agent_chat_response_part
      CLIENT_ERROR = :client_error
      GUARDRAIL_TRIGGERED = :guardrail_triggered
      DTMF_REQUEST = :dtmf_request
      AGENT_RESPONSE_COMPLETE = :agent_response_complete
      CONTEXT_USAGE = :context_usage
      INTERNAL_TURN_PROBABILITY = :internal_turn_probability
      INTERNAL_TENTATIVE_AGENT_RESPONSE = :internal_tentative_agent_response

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
