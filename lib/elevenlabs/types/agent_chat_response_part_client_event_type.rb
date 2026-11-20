# frozen_string_literal: true

module Elevenlabs
  module Types
    module AgentChatResponsePartClientEventType
      extend ::Elevenlabs::Internal::Types::Enum

      AGENT_CHAT_RESPONSE_PART = :agent_chat_response_part

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
