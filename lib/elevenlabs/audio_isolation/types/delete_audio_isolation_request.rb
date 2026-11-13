# frozen_string_literal: true

module Elevenlabs
  module AudioIsolation
    module Types
      class DeleteAudioIsolationRequest < ::Elevenlabs::Internal::Types::Model
        field :history_item_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
