# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Types
          class GetContentDocumentsRequest < ::Elevenlabs::Internal::Types::Model
            field :documentation_id, -> { String }, optional: false, nullable: false
          end
        end
      end
    end
  end
end
