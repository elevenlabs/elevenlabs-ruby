# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Types
        class DeleteProjectRequest < ::Elevenlabs::Internal::Types::Model
          field :project_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
