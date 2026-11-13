# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class ListBranchesRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :include_archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :limit, -> { Integer }, optional: true, nullable: true

          field :include_commit_status, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        end
      end
    end
  end
end
