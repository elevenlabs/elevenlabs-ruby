# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioSegment < ::Elevenlabs::Internal::Types::Model
      field :start_ms, -> { Integer }, optional: false, nullable: false
      field :end_ms, -> { Integer }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :segment_type, -> { String }, optional: true, nullable: true
      field :has_speech, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :has_music, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :pacing, -> { String }, optional: true, nullable: true

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
