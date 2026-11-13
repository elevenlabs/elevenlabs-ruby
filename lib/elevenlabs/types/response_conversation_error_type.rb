# frozen_string_literal: true

module Elevenlabs
  module Types
    module ResponseConversationErrorType
      extend ::Elevenlabs::Internal::Types::Enum

      SYSTEM_ERROR = :system_error
      CALL_INITIALIZATION_ERROR = :call_initialization_error
      LINE_BUSY = :line_busy
      NO_ANSWER = :no_answer
      CALL_REJECTED = :call_rejected
      BLOCKED_BY_USER = :blocked_by_user
      AGENT_CONFIGURATION_ERROR = :agent_configuration_error
      INVALID_CLIENT_REQUEST = :invalid_client_request
      PERMISSION_ERROR = :permission_error
      ENTITLEMENT_EXCEEDED = :entitlement_exceeded
      CLIENT_DISCONNECTED = :client_disconnected
      LLM_ERROR = :llm_error
      SPEECH_ERROR = :speech_error
      TOOL_ERROR = :tool_error
      INTEGRATION_ERROR = :integration_error
      GUARDRAIL_TRIGGERED = :guardrail_triggered
      SAFETY_VIOLATION = :safety_violation
      MAX_DURATION_EXCEEDED = :max_duration_exceeded
      POST_PROCESSING_ERROR = :post_processing_error

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
