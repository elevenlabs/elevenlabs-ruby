# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class GetConversationsRequest < ::Elevenlabs::Internal::Types::Model
          field :conversation_id, -> { String }, optional: false, nullable: false

          field :format, -> { ::Elevenlabs::Agents::Conversations::Types::GetConversationsRequestFormat }, optional: true, nullable: true
        end
      end
    end
  end
end
