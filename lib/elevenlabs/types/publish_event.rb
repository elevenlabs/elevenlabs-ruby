# frozen_string_literal: true

module Elevenlabs
  module Types
    module PublishEvent
      extend ::Elevenlabs::Internal::Types::Union

      member -> { ::Elevenlabs::Types::UserAudioChunk }
      member -> { ::Elevenlabs::Types::Feedback }
      member -> { ::Elevenlabs::Types::UserMessage }
      member -> { ::Elevenlabs::Types::UserActivity }
      member -> { ::Elevenlabs::Types::MultimodalMessage }
      member -> { ::Elevenlabs::Types::ConversationPong }
      member -> { ::Elevenlabs::Types::ClientToolResult }
      member -> { ::Elevenlabs::Types::McpToolApprovalResult }
      member -> { ::Elevenlabs::Types::ContextualUpdate }
      member -> { ::Elevenlabs::Types::ConversationInitiationClientData }

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
