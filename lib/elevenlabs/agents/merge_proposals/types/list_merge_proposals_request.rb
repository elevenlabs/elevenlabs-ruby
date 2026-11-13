# frozen_string_literal: true

module Elevenlabs
  module Agents
    module MergeProposals
      module Types
        class ListMergeProposalsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :status, -> { ::Elevenlabs::Types::MergeProposalStatus }, optional: true, nullable: true

          field :source_branch_id, -> { String }, optional: true, nullable: true

          field :target_branch_id, -> { String }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
