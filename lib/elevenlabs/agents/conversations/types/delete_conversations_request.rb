# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class DeleteConversationsRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_id, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
