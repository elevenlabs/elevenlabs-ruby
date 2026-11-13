# frozen_string_literal: true

module Elevenlabs
  module PronunciationDictionaries
    module Types
      class ListPronunciationDictionariesRequest < ::Elevenlabs::Internal::Types::Model
        field :cursor, -> { String }, optional: true, nullable: true

        field :page_size, -> { Integer }, optional: true, nullable: true

        field :sort, -> { ::Elevenlabs::Studio::Projects::PronunciationDictionaries::Types::ListPronunciationDictionariesRequestSort }, optional: true, nullable: true

        field :sort_direction, -> { String }, optional: true, nullable: true

        field :include_archived, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      end
    end
  end
end
