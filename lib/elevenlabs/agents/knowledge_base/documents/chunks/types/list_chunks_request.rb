# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Chunks
          module Types
            class ListChunksRequest < ::Elevenlabs::Internal::Types::Model
              field :documentation_id, -> { String }, optional: false, nullable: false

              field :embedding_model, -> { ::Elevenlabs::Types::EmbeddingModelEnum }, optional: false, nullable: false

              field :page_size, -> { Integer }, optional: true, nullable: true

              field :cursor, -> { String }, optional: true, nullable: true
            end
          end
        end
      end
    end
  end
end
