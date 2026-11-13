# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module Chapters
        module Types
          class ListChaptersRequest < ::Elevenlabs::Internal::Types::Model
            field :project_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
