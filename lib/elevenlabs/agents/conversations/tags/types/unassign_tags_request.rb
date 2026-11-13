# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Tags
        module Types
          class UnassignTagsRequest < ::Elevenlabs::Internal::Types::Model
            field :conversation_id, -> { String }, optional: false, nullable: false

            field :tag_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
