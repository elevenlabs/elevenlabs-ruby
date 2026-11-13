# frozen_string_literal: true

module Elevenlabs
  module Types
    class CharacterMetadataResponseModel < ::Elevenlabs::Internal::Types::Model
      field :description, -> { String }, optional: true, nullable: true
      field :sample_message, -> { String }, optional: true, nullable: true
      field :voice_creation_prompt_suggestion, -> { String }, optional: true, nullable: true
      field :gender, -> { ::Elevenlabs::Types::CharacterGender }, optional: true, nullable: false
      field :age, -> { ::Elevenlabs::Types::CharacterAge }, optional: true, nullable: false
      field :accent, -> { String }, optional: true, nullable: true
      field :role, -> { ::Elevenlabs::Types::CharacterRole }, optional: true, nullable: true

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
