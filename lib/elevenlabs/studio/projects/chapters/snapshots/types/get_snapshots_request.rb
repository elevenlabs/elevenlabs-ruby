# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Chapters
        module Snapshots
          module Types
            class GetSnapshotsRequest < ::Elevenlabs::Internal::Types::Model
              field :project_id, -> { String }, optional: false, nullable: false

              field :chapter_id, -> { String }, optional: false, nullable: false

              field :chapter_snapshot_id, -> { String }, optional: false, nullable: false
            end
          end
        end
      end
    end
  end
end
