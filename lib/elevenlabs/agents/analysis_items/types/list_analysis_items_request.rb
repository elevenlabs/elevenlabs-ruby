# frozen_string_literal: true

module Elevenlabs
  module Agents
    module AnalysisItems
      module Types
        class ListAnalysisItemsRequest < ::Elevenlabs::Internal::Types::Model
          field :search, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :kind, -> { ::Elevenlabs::Types::AnalysisItemKind }, optional: true, nullable: true

          field :analysis_item_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

          field :created_by_user_id, -> { String }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
