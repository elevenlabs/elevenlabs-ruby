# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Types
      class DeleteDocumentRagIndexAgentsRequest < ::Elevenlabs::Internal::Types::Model
        field :documentation_id, -> { String }, optional: false, nullable: false

        field :rag_index_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
