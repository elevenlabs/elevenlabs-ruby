# frozen_string_literal: true

module Elevenlabs
  module Types
    class CueOptionsRequest < ::Elevenlabs::Internal::Types::Model
      field :min_duration_ms, -> { Integer }, optional: true, nullable: false
      field :max_duration_ms, -> { Integer }, optional: true, nullable: false
      field :max_lines_per_cue, -> { Integer }, optional: true, nullable: false
      field :max_chars_per_line, -> { Integer }, optional: true, nullable: false
      field :max_chars_per_s, -> { Integer }, optional: true, nullable: true
      field :min_gap_between_cues_frames, -> { Integer }, optional: true, nullable: true

      def validate!
        ::Elevenlabs::Validator.validate_integer!(min_duration_ms, 'min_duration_ms', max: 2000)
        ::Elevenlabs::Validator.validate_integer!(max_duration_ms, 'max_duration_ms', min: 4000)
        ::Elevenlabs::Validator.validate_integer!(max_lines_per_cue, 'max_lines_per_cue', min: 1, max: 3)
        ::Elevenlabs::Validator.validate_integer!(max_chars_per_line, 'max_chars_per_line', min: 16, max: 50)
        ::Elevenlabs::Validator.validate_integer!(max_chars_per_s, 'max_chars_per_s', min: 15, max: 30)
        ::Elevenlabs::Validator.validate_integer!(min_gap_between_cues_frames, 'min_gap_between_cues_frames', min: 0, max: 6)
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
