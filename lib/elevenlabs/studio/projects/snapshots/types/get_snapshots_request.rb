# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Snapshots
        module Types
          class GetSnapshotsRequest < ::Elevenlabs::Internal::Types::Model
            field :project_id, -> { String }, optional: false, nullable: false

            field :project_snapshot_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
