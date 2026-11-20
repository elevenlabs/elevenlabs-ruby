# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class StreamTurnEventsConversationsRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_id, -> { String }, optional: false, nullable: false

          field :turn_id, -> { String }, optional: false, nullable: false

          field :last_event_id, -> { String }, optional: true, nullable: true, api_name: 'Last-Event-ID'
        end
      end
    end
  end
end
