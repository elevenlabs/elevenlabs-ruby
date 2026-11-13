# frozen_string_literal: true

module Elevenlabs
  module Dubbing
    module Project
      module Types
        class ListProjectRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :status, -> { String }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Dubbing::Project::Types::ListProjectRequestSortDirection }, optional: true, nullable: true
        end
      end
    end
  end
end
