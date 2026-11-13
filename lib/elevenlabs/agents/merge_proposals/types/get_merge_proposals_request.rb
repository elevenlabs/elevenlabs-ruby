# frozen_string_literal: true

module Elevenlabs
  module Agents
    module MergeProposals
      module Types
        class GetMergeProposalsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :merge_proposal_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
