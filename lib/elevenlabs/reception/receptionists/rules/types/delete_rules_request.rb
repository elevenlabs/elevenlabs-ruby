# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Receptionists
      module Rules
        module Types
          class DeleteRulesRequest < ::Elevenlabs::Internal::Types::Model
            field :agent_id, -> { String }, optional: false, nullable: false

            field :rule_id, -> { String }, optional: false, nullable: false

            field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          end
        end
      end
    end
  end
end
