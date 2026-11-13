# frozen_string_literal: true

module Elevenlabs
  module Types
    class CharacterResponseModel < ::Elevenlabs::Internal::Types::Model
      field :character_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :metadata, -> { ::Elevenlabs::Types::CharacterMetadataResponseModel }, optional: false, nullable: false
      field :recommended_voice_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
