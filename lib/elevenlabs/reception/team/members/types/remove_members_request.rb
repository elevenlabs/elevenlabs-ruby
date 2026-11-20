# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Team
      module Members
        module Types
          class RemoveMembersRequest < ::Elevenlabs::Internal::Types::Model
            field :user_id, -> { String }, optional: false, nullable: false

            field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
          end
        end
      end
    end
  end
end
