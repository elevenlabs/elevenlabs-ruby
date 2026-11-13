# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Folders
        module Types
          class GetFoldersRequest < ::Elevenlabs::Internal::Types::Model
            field :folder_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
