# frozen_string_literal: true

module Elevenlabs
  module History
    module Types
      class DeleteHistoryRequest < ::Elevenlabs::Internal::Types::Model
        field :history_item_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
