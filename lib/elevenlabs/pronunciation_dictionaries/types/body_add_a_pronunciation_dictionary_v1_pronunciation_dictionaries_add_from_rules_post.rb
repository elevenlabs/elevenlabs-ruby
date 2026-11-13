# frozen_string_literal: true

module Elevenlabs
  module PronunciationDictionaries
    module Types
      class BodyAddAPronunciationDictionaryV1PronunciationDictionariesAddFromRulesPost < ::Elevenlabs::Internal::Types::Model
        field :rules, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::PronunciationDictionaries::Types::BodyAddAPronunciationDictionaryV1PronunciationDictionariesAddFromRulesPostRulesItem] }, optional: false, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :description, -> { String }, optional: true, nullable: true
        field :workspace_access, -> { ::Elevenlabs::PronunciationDictionaries::Types::BodyAddAPronunciationDictionaryV1PronunciationDictionariesAddFromRulesPostWorkspaceAccess }, optional: true, nullable: true

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
