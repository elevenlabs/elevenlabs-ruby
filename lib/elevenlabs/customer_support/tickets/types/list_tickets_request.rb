# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tickets
      module Types
        class ListTicketsRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :status, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketStatus] }, optional: true, nullable: true

          field :priority, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketPriority] }, optional: true, nullable: true

          field :sla_status, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketSLAStatus] }, optional: true, nullable: true

          field :deadline_status, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketDeadlineStatus] }, optional: true, nullable: true

          field :requester_user_id, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

          field :assignee_id, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

          field :tag_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

          field :unassigned, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :sort_by, -> { ::Elevenlabs::Types::TicketSortBy }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true
        end
      end
    end
  end
end
