# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Types
        class GetMutedTracksProjectsRequest < ::Elevenlabs::Internal::Types::Model
          field :project_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
