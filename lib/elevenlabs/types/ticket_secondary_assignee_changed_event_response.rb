# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketSecondaryAssigneeChangedEventResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :visibility, -> { ::Elevenlabs::Types::TicketEventVisibility }, optional: false, nullable: false
      field :author, -> { ::Elevenlabs::Types::TicketSecondaryAssigneeChangedEventResponseAuthor }, optional: false, nullable: false
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :type, -> { ::Elevenlabs::Types::TicketSecondaryAssigneeChangedEventResponseType }, optional: false, nullable: false
      field :before, -> { ::Elevenlabs::Types::TicketSecondaryAssigneeChangedEventResponseBefore }, optional: false, nullable: true
      field :after, -> { ::Elevenlabs::Types::TicketSecondaryAssigneeChangedEventResponseAfter }, optional: false, nullable: true

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
