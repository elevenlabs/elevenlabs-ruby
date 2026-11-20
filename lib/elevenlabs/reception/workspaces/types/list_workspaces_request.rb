# frozen_string_literal: true

module Elevenlabs
  module Reception
    module Workspaces
      module Types
        class ListWorkspacesRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
