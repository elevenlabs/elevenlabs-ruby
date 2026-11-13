# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioOutputMulti < ::Elevenlabs::Internal::Types::Model
      field :audio, -> { String }, optional: false, nullable: false
      field :is_final, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :normalized_alignment, -> { ::Elevenlabs::Types::AudioOutputMultiNormalizedAlignment }, optional: true, nullable: false
      field :alignment, -> { ::Elevenlabs::Types::AudioOutputMultiAlignment }, optional: true, nullable: false
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
