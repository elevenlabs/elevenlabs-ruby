# frozen_string_literal: true

module Elevenlabs
  module Types
    class GenerationChunkInput < ::Elevenlabs::Internal::Types::Model
      field :text, -> { String }, optional: false, nullable: false
      field :duration_ms, -> { Integer }, optional: false, nullable: false
      field :positive_styles, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :negative_styles, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :context_adherence, -> { ::Elevenlabs::Types::GenerationChunkInputContextAdherence }, optional: true, nullable: false
      field :conditioning_ref, -> { ::Elevenlabs::Types::AudioRefChunk }, optional: true, nullable: true
      field :condition_strength, -> { ::Elevenlabs::Types::ConditionStrength }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(text, 'text', max_length: 6132)
        ::Elevenlabs::Validator.validate_integer!(duration_ms, 'duration_ms', min: 3000, max: 120_000)
        ::Elevenlabs::Validator.validate_array!(positive_styles, 'positive_styles', max_items: 50)
        ::Elevenlabs::Validator.validate_array!(negative_styles, 'negative_styles', max_items: 50)
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
