# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Types
        class GetSignedURLConversationsRequest < ::Elevenlabs::Internal::Types::Model
          field :agent_id, -> { String }, optional: false, nullable: false

          field :include_conversation_id, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :branch_id, -> { String }, optional: true, nullable: true

          field :version_id, -> { String }, optional: true, nullable: true

          field :environment, -> { String }, optional: true, nullable: true

          field :debug_events_request, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
        end
      end
    end
  end
end
