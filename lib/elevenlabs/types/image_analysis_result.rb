# frozen_string_literal: true

module Elevenlabs
  module Types
    class ImageAnalysisResult < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: true, nullable: true
      field :mood_and_style, -> { String }, optional: true, nullable: true
      field :composition_notes, -> { String }, optional: true, nullable: true
      field :visible_text, -> { String }, optional: true, nullable: true
      field :subjects, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ImageSubject] }, optional: true, nullable: false

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
