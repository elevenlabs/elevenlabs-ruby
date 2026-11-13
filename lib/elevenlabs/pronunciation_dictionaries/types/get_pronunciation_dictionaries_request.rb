# frozen_string_literal: true

module Elevenlabs
  module PronunciationDictionaries
    module Types
      class GetPronunciationDictionariesRequest < ::Elevenlabs::Internal::Types::Model
        field :pronunciation_dictionary_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
