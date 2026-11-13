# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioAnalysisResult < ::Elevenlabs::Internal::Types::Model
      field :title, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :content_type, -> { String }, optional: true, nullable: true
      field :overall_pacing, -> { String }, optional: true, nullable: true
      field :segments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioSegment] }, optional: true, nullable: false
      field :key_moments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioKeyMoment] }, optional: true, nullable: false

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
