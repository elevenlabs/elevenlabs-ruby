# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Types
        class SearchKnowledgeBaseRequest < ::Elevenlabs::Internal::Types::Model
          field :query, -> { String }, optional: false, nullable: false

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :types, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseDocumentType] }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
