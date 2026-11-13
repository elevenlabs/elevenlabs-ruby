# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Documents
        module Chunk
          module Types
            class GetChunkRequest < ::Elevenlabs::Internal::Types::Model
              field :documentation_id, -> { String }, optional: false, nullable: false

              field :chunk_id, -> { String }, optional: false, nullable: false

              field :embedding_model, -> { ::Elevenlabs::Types::EmbeddingModelEnum }, optional: true, nullable: true
            end
          end
        end
      end
    end
  end
end
