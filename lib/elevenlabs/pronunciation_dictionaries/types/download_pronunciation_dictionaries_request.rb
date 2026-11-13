# frozen_string_literal: true

module Elevenlabs
  module PronunciationDictionaries
    module Types
      class DownloadPronunciationDictionariesRequest < ::Elevenlabs::Internal::Types::Model
        field :dictionary_id, -> { String }, optional: false, nullable: false

        field :version_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
