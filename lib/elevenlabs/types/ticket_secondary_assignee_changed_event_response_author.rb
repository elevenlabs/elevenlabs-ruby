# frozen_string_literal: true

module Elevenlabs
  module Types
    module TicketSecondaryAssigneeChangedEventResponseAuthor
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::TicketEventAiAgentAuthorResponse }, key: 'ai_agent'
      member -> { ::Elevenlabs::Types::TicketEventHumanAgentAuthorResponse }, key: 'human_agent'
      member -> { ::Elevenlabs::Types::TicketEventRequesterAuthorResponse }, key: 'requester'

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
