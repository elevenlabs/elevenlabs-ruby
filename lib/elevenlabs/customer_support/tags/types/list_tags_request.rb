# frozen_string_literal: true

module Elevenlabs
  module CustomerSupport
    module Tags
      module Types
        class ListTagsRequest < ::Elevenlabs::Internal::Types::Model
          field :ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

          field :include_archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :cursor, -> { String }, optional: true, nullable: true
        end
      end
    end
  end
end
