# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Branches
      module Types
        class PreviewRebaseBranchesRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :branch_id, -> { String }, optional: false, nullable: false

          field :source_branch_id, -> { String }, optional: true, nullable: true

          field :include_procedure_generated_workflow_elements, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        end
      end
    end
  end
end
