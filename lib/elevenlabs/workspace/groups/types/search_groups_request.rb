# frozen_string_literal: true

module Elevenlabs
  module Workspace
    module Groups
      module Types
        class SearchGroupsRequest < ::Elevenlabs::Internal::Types::Model
          field :name, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
