# frozen_string_literal: true

module Elevenlabs
  module Types
    class GetAgentConversationTicketsPageResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agent_conversation_tickets, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentConversationTicketResponseModel] }, optional: false, nullable: false
      field :next_cursor, -> { String }, optional: true, nullable: true
      field :has_more, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false

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
