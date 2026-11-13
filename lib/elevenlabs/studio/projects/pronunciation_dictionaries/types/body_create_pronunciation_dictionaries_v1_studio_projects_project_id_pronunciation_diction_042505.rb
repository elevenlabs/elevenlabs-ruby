# frozen_string_literal: true

module Elevenlabs
  module Studio
    module Projects
      module PronunciationDictionaries
        module Types
          class BodyCreatePronunciationDictionariesV1StudioProjectsProjectIDPronunciationDictionariesPost < ::Elevenlabs::Internal::Types::Model
            field :pronunciation_dictionary_locators, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::BodyTextToSpeechFullPronunciationDictionaryLocatorsItem] }, optional: false, nullable: false
            field :invalidate_affected_text, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

            def self.load(str)
              coerce(::JSON.parse(str, symbolize_names: true))
            end

            def self.dump(value)
              coerced = coerce(value)
              ::JSON.generate(coerced.nil? || !coerced.respond_to?(:to_h) ? coerced : coerced.to_h)
            end
          end
        end
      end
    end
  end
end
