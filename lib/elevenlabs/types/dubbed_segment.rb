# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbedSegment < ::Elevenlabs::Internal::Types::Model
      field :start_time, -> { Float }, optional: false, nullable: false
      field :end_time, -> { Float }, optional: false, nullable: false
      field :text, -> { String }, optional: false, nullable: true
      field :subtitles, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::SegmentSubtitleFrame] }, optional: false, nullable: false
      field :audio_stale, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: false, nullable: false
      field :media_ref, -> { ::Elevenlabs::Types::DubbingMediaReference }, optional: false, nullable: true

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
