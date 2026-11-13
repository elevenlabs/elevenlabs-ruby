# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Types
        class GetProjectsRequest < ::Elevenlabs::Internal::Types::Model
          field :project_id, -> { String }, optional: false, nullable: false

          field :share_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
