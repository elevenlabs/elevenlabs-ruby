# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class GetDocumentsRequest < ::Elevenlabs::Internal::Types::Model
            field :documentation_id, -> { String }, optional: false, nullable: false

            field :agent_id, -> { String }, optional: true, nullable: true
          end
        end
      end
    end
  end
end
