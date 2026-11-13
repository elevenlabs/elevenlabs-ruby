# frozen_string_literal: true

module Elevenlabs
  module Types
    class SegmentedJSONExportOptions < ::Elevenlabs::Internal::Types::Model
      field :include_speakers, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :include_timestamps, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :format, -> { ::Elevenlabs::Types::SegmentedJSONExportOptionsFormat }, optional: false, nullable: false
      field :segment_on_silence_longer_than_s, -> { Float }, optional: true, nullable: true
      field :max_segment_duration_s, -> { Float }, optional: true, nullable: true
      field :max_segment_chars, -> { Integer }, optional: true, nullable: true

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
