# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module AuthConnections
      module Types
        class DeleteAuthConnectionsRequest < ::Elevenlabs::Internal::Types::Model
          field :auth_connection_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
