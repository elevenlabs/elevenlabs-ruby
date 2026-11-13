# frozen_string_literal: true

module Elevenlabs
  module Types
    class SongSection < ::Elevenlabs::Internal::Types::Model
      field :section_name, -> { String }, optional: false, nullable: false
      field :positive_local_styles, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :negative_local_styles, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :duration_ms, -> { Integer }, optional: false, nullable: false
      field :lines, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :source_from, -> { ::Elevenlabs::Types::SectionSource }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_string!(section_name, 'section_name', min_length: 1, max_length: 100)
        ::Elevenlabs::Validator.validate_array!(positive_local_styles, 'positive_local_styles', max_items: 50)
        ::Elevenlabs::Validator.validate_array!(negative_local_styles, 'negative_local_styles', max_items: 50)
        ::Elevenlabs::Validator.validate_integer!(duration_ms, 'duration_ms', min: 3000, max: 120_000)
        ::Elevenlabs::Validator.validate_array!(lines, 'lines', max_items: 30)
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
