# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeakerSegment < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :start_time, -> { Float }, optional: false, nullable: false
      field :end_time, -> { Float }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: false
      field :subtitles, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SegmentSubtitleFrame] }, optional: false, nullable: false
      field :dubs, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::DubbedSegment] }, optional: false, nullable: false

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
