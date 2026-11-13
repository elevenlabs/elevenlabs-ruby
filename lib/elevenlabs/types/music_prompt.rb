# frozen_string_literal: true

module Elevenlabs
  module Types
    class MusicPrompt < ::Elevenlabs::Internal::Types::Model
      field :positive_global_styles, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :negative_global_styles, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :sections, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SongSection] }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(positive_global_styles, 'positive_global_styles', max_items: 50)
        ::Elevenlabs::Validator.validate_array!(negative_global_styles, 'negative_global_styles', max_items: 50)
        ::Elevenlabs::Validator.validate_array!(sections, 'sections', max_items: 30)
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
