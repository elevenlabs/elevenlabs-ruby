# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Workspaces
      module Types
        class CompleteOnboardingWorkspacesRequest < ::Elevenlabs::Internal::Types::Model
          field :workspace_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
