# frozen_string_literal: true

module Elevenlabs
  module Agents
    module KnowledgeBase
      module Types
        class ListKnowledgeBaseRequest < ::Elevenlabs::Internal::Types::Model
          field :page_size, -> { Integer }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :show_only_owned_documents, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :created_by_user_id, -> { String }, optional: true, nullable: true

          field :types, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::KnowledgeBaseDocumentType] }, optional: true, nullable: true

          field :parent_folder_id, -> { String }, optional: true, nullable: true

          field :ancestor_folder_id, -> { String }, optional: true, nullable: true

          field :folders_first, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Types::SortDirection }, optional: true, nullable: true

          field :sort_by, -> { ::Elevenlabs::Types::KnowledgeBaseSortBy }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
