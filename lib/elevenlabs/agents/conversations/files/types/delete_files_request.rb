# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Conversations
      module Files
        module Types
          class DeleteFilesRequest < ::Elevenlabs::Internal::Types::Model
            field :file_id, -> { String }, optional: false, nullable: false

            field :conversation_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
