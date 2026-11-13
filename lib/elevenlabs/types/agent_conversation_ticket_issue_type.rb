# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentConversationTicketIssueType
      extend ::Elevenlabs::Internal::Types::Enum

      KNOWLEDGE_GAP = :knowledge_gap
      INCORRECT_INFORMATION = :incorrect_information
      DOCUMENTATION_GAP = :documentation_gap
      PRODUCT_FEEDBACK = :product_feedback
      PLATFORM_BUG = :platform_bug
      TOOL_ISSUE = :tool_issue
      MISSING_TOOL = :missing_tool
      UNNECESSARY_ESCALATION = :unnecessary_escalation
      WRONG_ACTION = :wrong_action

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
