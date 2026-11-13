# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioChunkMulti < ::Elevenlabs::Internal::Types::Model
      field :audio, -> { String }, optional: true, nullable: false
      field :alignment, -> { ::Elevenlabs::Types::AudioChunkMultiAlignment }, optional: true, nullable: false
      field :normalized_alignment, -> { ::Elevenlabs::Types::AudioChunkMultiNormalizedAlignment }, optional: true, nullable: false
      field :context_id, -> { String }, optional: true, nullable: false

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
