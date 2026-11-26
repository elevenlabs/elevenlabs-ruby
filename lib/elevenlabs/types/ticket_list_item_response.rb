# frozen_string_literal: true

module Elevenlabs
  module Types
    class TicketListItemResponse < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :subject, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::TicketStatus }, optional: false, nullable: false
      field :priority, -> { ::Elevenlabs::Types::TicketPriority }, optional: false, nullable: false
      field :requester, -> { ::Elevenlabs::Types::TicketRequesterResponse }, optional: false, nullable: false
      field :assignee, -> { ::Elevenlabs::Types::TicketListItemResponseAssignee }, optional: false, nullable: true
      field :secondary_assignee, -> { ::Elevenlabs::Types::TicketListItemResponseSecondaryAssignee }, optional: false, nullable: true
      field :subscribers, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketSubscriberResponse] }, optional: false, nullable: false
      field :tag_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :sla, -> { ::Elevenlabs::Types::TicketSLASummaryResponse }, optional: false, nullable: true
      field :deadline_at_unix_secs, -> { Integer }, optional: false, nullable: true
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false

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
