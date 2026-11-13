# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Topics
        module Types
          class GetTopicsRequest < ::Elevenlabs::Internal::Types::Model
            field :agent_id, -> { String }, optional: false, nullable: false

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :sort_by, -> { ::Elevenlabs::Types::TopicSortBy }, optional: true, nullable: true

            field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

            field :from_unix_secs, -> { Integer }, optional: true, nullable: true

            field :to_unix_secs, -> { Integer }, optional: true, nullable: true

            field :include_evaluation_criteria, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
