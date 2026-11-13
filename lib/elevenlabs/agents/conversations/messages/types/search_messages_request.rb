# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Messages
        module Types
          class SearchMessagesRequest < ::Elevenlabs::Internal::Types::Model
            field :text_query, -> { String }, optional: false, nullable: false

            field :agent_id, -> { String }, optional: true, nullable: true

            field :branch_id, -> { String }, optional: true, nullable: true

            field :page_size, -> { Integer }, optional: true, nullable: true

            field :cursor, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
