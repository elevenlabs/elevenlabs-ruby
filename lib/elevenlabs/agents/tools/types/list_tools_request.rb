# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tools
      module Types
        class ListToolsRequest < ::Elevenlabs::Internal::Types::Model
          field :search, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :show_only_owned_documents, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :created_by_user_id, -> { String }, optional: true, nullable: true

          field :types, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ToolTypeFilter] }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

          field :sort_by, -> { ::Elevenlabs::Types::ToolSortBy }, optional: true, nullable: true

          field :used_by_agent_id, -> { String }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
