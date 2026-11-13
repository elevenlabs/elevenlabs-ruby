# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class GetSummaryConversationsRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_id, -> { String }, optional: false, nullable: false

          field :max_messages, -> { Integer }, optional: true, nullable: true
        end
      end
    end
  end
end
