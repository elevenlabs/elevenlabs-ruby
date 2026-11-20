# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Services
      module Types
        class ListServicesRequest < ::Elevenlabs::Internal::Types::Model
          field :staff_id, -> { String }, optional: true, nullable: true

          field :asset_id, -> { String }, optional: true, nullable: true

          field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :kind, -> { ::Elevenlabs::Types::ReceptionServiceKind }, optional: true, nullable: true

          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
        end
      end
    end
  end
end
