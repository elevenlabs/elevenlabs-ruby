# frozen_string_literal: true

module Elevenlabs
  module Agents
    # A WebSocket connection to the `agents` channel (`/v1/convai/conversation`).
    #
    # Received messages queue for `#recv` and `#each` until `#start_listening` hands them to the
    # handlers registered with `#on`.
    class AgentsSocket
      include ::Elevenlabs::Internal::WebSocket::Channel

      RECEIVE_TYPES = [
        [::Elevenlabs::Types::ConversationInitiationMetadata, { 'type' => 'conversation_initiation_metadata' }, ['conversation_initiation_metadata_event']],
        [::Elevenlabs::Types::AgentResponseComplete, { 'type' => 'agent_response_complete' }, ['agent_response_complete_event']],
        [::Elevenlabs::Types::ContextUsage, { 'type' => 'context_usage' }, ['context_usage_event']],
        [::Elevenlabs::Types::McpToolCall, { 'type' => 'mcp_tool_call' }, ['mcp_tool_call']],
        [::Elevenlabs::Types::ClientError, { 'type' => 'client_error' }, ['error_event']],
        [::Elevenlabs::Types::GuardrailTriggered, { 'type' => 'guardrail_triggered' }, ['guardrail_triggered_event']],
        [::Elevenlabs::Types::ConversationUserTranscript, { 'type' => 'user_transcript' }, ['user_transcription_event']],
        [::Elevenlabs::Types::ConversationAgentResponse, { 'type' => 'agent_response' }, ['agent_response_event']],
        [::Elevenlabs::Types::QueueStatus, { 'type' => 'queue_status' }, ['queue_status_event']],
        [::Elevenlabs::Types::AgentResponseCorrection, { 'type' => 'agent_response_correction' }, ['agent_response_correction_event']],
        [::Elevenlabs::Types::AgentResponseMetadata, { 'type' => 'agent_response_metadata' }, ['agent_response_metadata_event']],
        [::Elevenlabs::Types::AudioResponse, { 'type' => 'audio' }, ['audio_event']],
        [::Elevenlabs::Types::Interruption, { 'type' => 'interruption' }, ['interruption_event']],
        [::Elevenlabs::Types::VadScore, { 'type' => 'vad_score' }, ['vad_score_event']],
        [::Elevenlabs::Types::AgentChatResponsePart, { 'type' => 'agent_chat_response_part' }, ['text_response_part']],
        [::Elevenlabs::Types::ClientToolCall, { 'type' => 'client_tool_call' }, ['client_tool_call']],
        [::Elevenlabs::Types::AgentToolResponse, { 'type' => 'agent_tool_response' }, ['agent_tool_response']],
        [::Elevenlabs::Types::AgentToolResponseFullPayload, { 'type' => 'agent_tool_response_full_payload' }, ['agent_tool_response_full_payload']],
        [::Elevenlabs::Types::AgentToolRequest, { 'type' => 'agent_tool_request' }, ['agent_tool_request']],
        [::Elevenlabs::Types::ConversationPing, { 'type' => 'ping' }, ['ping_event']],
        [::Elevenlabs::Types::McpConnectionStatus, { 'type' => 'mcp_connection_status' }, ['mcp_connection_status']],
      ].freeze

      UNION_TYPES = [::Elevenlabs::Types::SubscribeEvent].freeze

      # Sends a `PublishEvent` message.
      #
      # @param message [::Elevenlabs::Types::PublishEvent]
      # @raise [::Elevenlabs::Errors::WebSocketError] The connection is not open.
      # @return [void]
      def send_publish(message)
        send_json(message)
      end

      private

      def decode(text)
        data = parse_json(text)
        return [:raw, text] if data.equal?(NOT_JSON)

        match_json(data, RECEIVE_TYPES, UNION_TYPES) || [:unknown, data]
      end
    end
  end
end
