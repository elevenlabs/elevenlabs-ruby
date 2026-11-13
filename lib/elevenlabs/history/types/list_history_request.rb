# frozen_string_literal: true

module Elevenlabs
  module History
    module Types
      class ListHistoryRequest < ::Elevenlabs::Internal::Types::Model
        field :page_size, -> { Integer }, optional: true, nullable: true

        field :start_after_history_item_id, -> { String }, optional: true, nullable: true

        field :voice_id, -> { String }, optional: true, nullable: true

        field :model_id, -> { String }, optional: true, nullable: true

        field :date_before_unix, -> { Integer }, optional: true, nullable: true

        field :date_after_unix, -> { Integer }, optional: true, nullable: true

        field :sort_direction, -> { ::Elevenlabs::History::Types::ListHistoryRequestSortDirection }, optional: true, nullable: true

        field :search, -> { String }, optional: true, nullable: true

        field :source, -> { ::Elevenlabs::History::Types::ListHistoryRequestSource }, optional: true, nullable: true
      end
    end
  end
end
