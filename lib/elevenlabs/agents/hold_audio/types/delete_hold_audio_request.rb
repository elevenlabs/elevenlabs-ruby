# frozen_string_literal: true

module Elevenlabs
  module Agents
    module HoldAudio
      module Types
        class DeleteHoldAudioRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
