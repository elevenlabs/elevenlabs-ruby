# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class ListAgentsRequest < ::Elevenlabs::Internal::Types::Model
        field :page_size, -> { Integer }, optional: true, nullable: true

        field :search, -> { String }, optional: true, nullable: true

        field :archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :show_only_owned_agents, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

        field :created_by_user_id, -> { String }, optional: true, nullable: true

        field :tags, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

        field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

        field :sort_by, -> { ::Elevenlabs::Types::AgentSortBy }, optional: true, nullable: true

        field :cursor, -> { String }, optional: true, nullable: true
      end
    end
  end
end
