# frozen_string_literal: true

module Elevenlabs
  module Music
    module Finetunes
      module Types
        class ListFinetunesRequest < ::Elevenlabs::Internal::Types::Model
          field :cursor, -> { String }, optional: true, nullable: true

          field :page_size, -> { Integer }, optional: true, nullable: true

          field :visibility, -> { ::Elevenlabs::Types::FinetuneVisibility }, optional: true, nullable: true

          field :created_by, -> { ::Elevenlabs::Types::FinetuneCreatedBy }, optional: true, nullable: true

          field :sort, -> { ::Elevenlabs::Music::Finetunes::Types::ListFinetunesRequestSort }, optional: true, nullable: true

          field :sort_direction, -> { ::Elevenlabs::Music::Finetunes::Types::ListFinetunesRequestSortDirection }, optional: true, nullable: true
        end
      end
    end
  end
end
