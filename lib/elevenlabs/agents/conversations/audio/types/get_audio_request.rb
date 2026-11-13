# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Audio
        module Types
          class GetAudioRequest < ::Elevenlabs::Internal::Types::Model
            field :conversation_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
