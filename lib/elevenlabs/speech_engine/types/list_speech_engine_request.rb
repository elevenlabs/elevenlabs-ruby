# frozen_string_literal: true

module Elevenlabs
  module SpeechEngine
    module Types
      class ListSpeechEngineRequest < ::Elevenlabs::Internal::Types::Model
        field :page_size, -> { Integer }, optional: true, nullable: true

        field :search, -> { String }, optional: true, nullable: true

        field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

        field :sort_by, -> { ::Elevenlabs::Types::AgentSortBy }, optional: true, nullable: true

        field :cursor, -> { String }, optional: true, nullable: true
      end
    end
  end
end
