# frozen_string_literal: true

module Elevenlabs
  module Types
    class SongMetadata < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: false, nullable: true
      field :description, -> { String }, optional: false, nullable: true
      field :genres, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :is_explicit, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: true

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
