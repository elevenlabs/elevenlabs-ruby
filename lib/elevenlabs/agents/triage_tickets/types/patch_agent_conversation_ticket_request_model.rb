# frozen_string_literal: true

module Elevenlabs
  module Agents
    module TriageTickets
      module Types
        class PatchAgentConversationTicketRequestModel < ::Elevenlabs::Internal::Types::Model
          field :title, -> { String }, optional: true, nullable: true
          field :qa_comment, -> { String }, optional: true, nullable: true
          field :status, -> { ::Elevenlabs::Types::AgentConversationTicketStatus }, optional: true, nullable: false
          field :assignee_user_id, -> { String }, optional: true, nullable: true
          field :priority, -> { ::Elevenlabs::Types::AgentConversationTicketPriority }, optional: true, nullable: false

          def validate!
            ::Elevenlabs::Validator.validate_string!(title, 'title', min_length: 1, max_length: 120)
            ::Elevenlabs::Validator.validate_string!(qa_comment, 'qa_comment', min_length: 1, max_length: 10_000)
          end

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
  end
end
