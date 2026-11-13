# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Tags
        module Types
          class ListTagsRequest < ::Elevenlabs::Internal::Types::Model
            field :page_size, -> { Integer }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
