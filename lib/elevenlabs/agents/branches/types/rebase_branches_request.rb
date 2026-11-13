# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class RebaseBranchesRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :branch_id, -> { String }, optional: false, nullable: false

          field :source_branch_id, -> { String }, optional: true, nullable: true

          field :body, -> { Object }, optional: true, nullable: false
        end
      end
    end
  end
end
