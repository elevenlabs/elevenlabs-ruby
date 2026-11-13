# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class GetAgentsRequest < ::Elevenlabs::Internal::Types::Model
        field :agent_id, -> { String }, optional: false, nullable: false

        field :version_id, -> { String }, optional: true, nullable: true

        field :branch_id, -> { String }, optional: true, nullable: true

        field :include_procedure_generated_workflow_elements, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      end
    end
  end
end
