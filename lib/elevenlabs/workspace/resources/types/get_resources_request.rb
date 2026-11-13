# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Resources
      module Types
        class GetResourcesRequest < ::Elevenlabs::Internal::Types::Model
          field :resource_id, -> { String }, optional: false, nullable: false

          field :resource_type, -> { ::Elevenlabs::Types::WorkspaceResourceType }, optional: false, nullable: false
        end
      end
    end
  end
end
