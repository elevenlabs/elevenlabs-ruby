# frozen_string_literal: true

module Elevenlabs
  module Agents
    module TriageTickets
      module Types
        class ListForWorkspaceTriageTicketsRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :agent_id, -> { String }, optional: true, nullable: true

          field :status, -> { ::Elevenlabs::Types::AgentConversationTicketStatus }, optional: true, nullable: true

          field :sources, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentConversationTicketSource] }, optional: true, nullable: true

          field :priorities, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AgentConversationTicketPriority] }, optional: true, nullable: true

          field :sort_by, -> { ::Elevenlabs::Types::AgentConversationTicketSortBy }, optional: true, nullable: true

          field :owner_user_id, -> { String }, optional: true, nullable: true

          field :assignee_user_id, -> { String }, optional: true, nullable: true

          field :issue_type, -> { ::Elevenlabs::Types::AgentConversationTicketIssueType }, optional: true, nullable: true

          field :label, -> { String }, optional: true, nullable: true

          field :merged_into_ticket_id, -> { String }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
