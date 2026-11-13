# frozen_string_literal: true

module Elevenlabs
  module Types
    class AgentConversationTicketResponseModel < ::Elevenlabs::Internal::Types::Model
      field :agentqa_ticket_id, -> { String }, optional: false, nullable: false
      field :workspace_id, -> { String }, optional: false, nullable: false
      field :owner_user_id, -> { String }, optional: false, nullable: false
      field :agent_id, -> { String }, optional: false, nullable: false
      field :needs_clustering, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: true
      field :issue_type, -> { ::Elevenlabs::Types::AgentConversationTicketIssueType }, optional: false, nullable: false
      field :labels, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :conversation_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :first_seen_unix_secs, -> { Integer }, optional: false, nullable: true
      field :last_seen_unix_secs, -> { Integer }, optional: false, nullable: true
      field :qa_comment, -> { String }, optional: false, nullable: true
      field :ticket_comments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketCommentResponseModel] }, optional: false, nullable: false
      field :turn_comments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TurnCommentResponseModel] }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::AgentConversationTicketStatus }, optional: false, nullable: false
      field :priority, -> { ::Elevenlabs::Types::AgentConversationTicketPriority }, optional: false, nullable: false
      field :priority_changes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketPriorityChangeResponseModel] }, optional: false, nullable: false
      field :status_changes, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TicketStatusChangeResponseModel] }, optional: false, nullable: false
      field :merged_into_ticket_id, -> { String }, optional: true, nullable: true
      field :source, -> { ::Elevenlabs::Types::AgentConversationTicketSource }, optional: false, nullable: false
      field :assignee_user_id, -> { String }, optional: false, nullable: true
      field :created_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :updated_at_unix_secs, -> { Integer }, optional: false, nullable: false
      field :search_match, -> { ::Elevenlabs::Types::TicketSearchMatchResponseModel }, optional: true, nullable: true

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
