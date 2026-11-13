# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class GetBranchesRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :branch_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
