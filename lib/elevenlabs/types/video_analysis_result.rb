# frozen_string_literal: true

module Elevenlabs
  module Types
    class VideoAnalysisResult < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: true, nullable: true
      field :overall_pacing, -> { String }, optional: true, nullable: true
      field :subjects, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VideoSubject] }, optional: true, nullable: false
      field :segments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VideoSegment] }, optional: true, nullable: false
      field :key_moments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VideoKeyMoment] }, optional: true, nullable: false

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
