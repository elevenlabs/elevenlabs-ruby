# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Summaries
          module Types
            class GetSummariesRequest < ::Elevenlabs::Internal::Types::Model
              field :document_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
            end
          end
        end
      end
    end
  end
end
