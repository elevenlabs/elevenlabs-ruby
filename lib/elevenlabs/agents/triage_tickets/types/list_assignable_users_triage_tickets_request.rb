# frozen_string_literal: true

module Elevenlabs
  module Agents
    module TriageTickets
      module Types
        class ListAssignableUsersTriageTicketsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
