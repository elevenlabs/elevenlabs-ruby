# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Realtime
      module Types
        class ClearConversationGroupRealtimeRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
