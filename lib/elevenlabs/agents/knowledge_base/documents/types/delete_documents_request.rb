# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class DeleteDocumentsRequest < ::Elevenlabs::Internal::Types::Model
            field :documentation_id, -> { String }, optional: false, nullable: false

            field :force, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
