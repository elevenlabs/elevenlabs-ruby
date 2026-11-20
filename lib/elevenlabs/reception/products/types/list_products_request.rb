# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Products
      module Types
        class ListProductsRequest < ::Elevenlabs::Internal::Types::Model
          field :group, -> { String }, optional: true, nullable: true

          field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
        end
      end
    end
  end
end
