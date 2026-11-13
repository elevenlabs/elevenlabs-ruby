# frozen_string_literal: true

module Elevenlabs
  module Agents
    module Tests
      module Types
        class ListTestsRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :search, -> { String }, optional: true, nullable: true

          field :parent_folder_id, -> { String }, optional: true, nullable: true

          field :types, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::TestType] }, optional: true, nullable: true

          field :include_folders, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :sort_mode, -> { ::Elevenlabs::Agents::Tests::Types::ListTestsRequestSortMode }, optional: true, nullable: true

          field :sharing_mode, -> { ::Elevenlabs::Types::TestSharingMode }, optional: true, nullable: true

          field :created_by_user_id, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
