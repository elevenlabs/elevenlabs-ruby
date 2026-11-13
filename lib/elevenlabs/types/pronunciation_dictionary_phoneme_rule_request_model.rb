# frozen_string_literal: true

module Elevenlabs
  module Types
    class PronunciationDictionaryPhonemeRuleRequestModel < ::Elevenlabs::Internal::Types::Model
      field :string_to_replace, -> { String }, optional: false, nullable: false
      field :case_sensitive, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :word_boundaries, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::PronunciationDictionaryPhonemeRuleRequestModelType }, optional: false, nullable: false
      field :phoneme, -> { String }, optional: false, nullable: false
      field :alphabet, -> { String }, optional: false, nullable: false

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
