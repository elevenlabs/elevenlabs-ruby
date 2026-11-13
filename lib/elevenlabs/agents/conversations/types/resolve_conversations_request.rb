# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class ResolveConversationsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :reference, -> { String }, optional: false, nullable: false
        end
      end
    end
  end
end
