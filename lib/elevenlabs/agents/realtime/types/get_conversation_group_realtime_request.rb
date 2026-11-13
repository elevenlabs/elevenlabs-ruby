# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Realtime
      module Types
        class GetConversationGroupRealtimeRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_group_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
