# frozen_string_literal: true

module Elevenlabs
  module Types
    class ChunkingOverrideRequestModel < ::Elevenlabs::Internal::Types::Model
      field :max_chunk_size, -> { Integer }, optional: true, nullable: true
      field :overlap_percentage, -> { Integer }, optional: true, nullable: true
      field :custom_separators, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(max_chunk_size, 'max_chunk_size', min: 200)
        ::Elevenlabs::Validator.validate_integer!(overlap_percentage, 'overlap_percentage', min: 0, max: 25)
        ::Elevenlabs::Validator.validate_array!(custom_separators, 'custom_separators', max_items: 5)
      end

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
