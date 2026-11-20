# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Services
      module Types
        class GetServicesRequest < ::Elevenlabs::Internal::Types::Model
          field :service_id, -> { String }, optional: false, nullable: false

          field :xi_workspace_id, -> { String }, optional: false, nullable: false, api_name: 'xi-workspace-id'
        end
      end
    end
  end
end
