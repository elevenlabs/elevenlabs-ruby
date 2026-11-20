# frozen_string_literal: true

module Elevenlabs
  module Types
    class ChunkingOverride < ::Elevenlabs::Internal::Types::Model
      field :max_chunk_size, -> { Integer }, optional: false, nullable: true
      field :overlap_percentage, -> { Integer }, optional: false, nullable: true
      field :custom_separators, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: true

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
