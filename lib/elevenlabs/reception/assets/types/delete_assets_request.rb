# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Assets
      module Types
        class DeleteAssetsRequest < ::Elevenlabs::Internal::Types::Model
          field :asset_id, -> { String }, optional: false, nullable: false

          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
        end
      end
    end
  end
end
