# frozen_string_literal: true

module Elevenlabs
  module Types
    module GetTicketResponseEventsItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::TicketAssigneeChangedEventResponse }, key: 'assignee_changed'
      member -> { ::Elevenlabs::Types::TicketDeadlineChangedEventResponse }, key: 'deadline_changed'
      member -> { ::Elevenlabs::Types::TicketMessageEventResponse }, key: 'message'
      member -> { ::Elevenlabs::Types::TicketPriorityChangedEventResponse }, key: 'priority_changed'
      member -> { ::Elevenlabs::Types::TicketSecondaryAssigneeChangedEventResponse }, key: 'secondary_assignee_changed'
      member -> { ::Elevenlabs::Types::TicketStatusChangedEventResponse }, key: 'status_changed'
      member -> { ::Elevenlabs::Types::TicketSubjectChangedEventResponse }, key: 'subject_changed'
      member -> { ::Elevenlabs::Types::TicketSubscribersChangedEventResponse }, key: 'subscribers_changed'
      member -> { ::Elevenlabs::Types::TicketTagIDsChangedEventResponse }, key: 'tag_ids_changed'
      member -> { ::Elevenlabs::Types::TicketCreatedEventResponse }, key: 'ticket_created'
      member -> { ::Elevenlabs::Types::TicketDeletedEventResponse }, key: 'ticket_deleted'

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
