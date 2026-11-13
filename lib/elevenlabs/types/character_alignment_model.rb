# frozen_string_literal: true

module Elevenlabs
  module Types
    class CharacterAlignmentModel < ::Elevenlabs::Internal::Types::Model
      field :characters, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :character_start_times_seconds, -> { ::Elevenlabs::Internal::Types::Array[Float] }, optional: false, nullable: false
      field :character_end_times_seconds, -> { ::Elevenlabs::Internal::Types::Array[Float] }, optional: false, nullable: false

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
