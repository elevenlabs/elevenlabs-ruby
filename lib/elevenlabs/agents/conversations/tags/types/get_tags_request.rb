# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Tags
        module Types
          class GetTagsRequest < ::Elevenlabs::Internal::Types::Model
            field :tag_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
