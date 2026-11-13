# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Users
      module Types
        class ListUsersRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: true, nullable: true

          field :branch_id, -> { String }, optional: true, nullable: true

          field :call_start_before_unix, -> { Integer }, optional: true, nullable: true

          field :call_start_after_unix, -> { Integer }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :sort_by, -> { ::Elevenlabs::Types::UsersSortBy }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
