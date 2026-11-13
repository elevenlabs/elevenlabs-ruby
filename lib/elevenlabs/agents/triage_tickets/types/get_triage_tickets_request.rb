# frozen_string_literal: true

module Elevenlabs
  module Agents
    module TriageTickets
      module Types
        class GetTriageTicketsRequest < ::Elevenlabs::Internal::Types::Model
          field :agentqa_ticket_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
