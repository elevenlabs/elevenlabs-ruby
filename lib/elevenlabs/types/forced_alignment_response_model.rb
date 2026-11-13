# frozen_string_literal: true

module Elevenlabs
  module Types
    class ForcedAlignmentResponseModel < ::Elevenlabs::Internal::Types::Model
      field :characters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ForcedAlignmentCharacterResponseModel] }, optional: false, nullable: false
      field :words, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ForcedAlignmentWordResponseModel] }, optional: false, nullable: false
      field :loss, -> { Float }, optional: false, nullable: false

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
