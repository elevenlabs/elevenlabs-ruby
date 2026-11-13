# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingTargetTranscriptSegment < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :speaker_id, -> { String }, optional: false, nullable: false
      field :start_s, -> { Float }, optional: false, nullable: false
      field :end_s, -> { Float }, optional: false, nullable: false
      field :source_text, -> { String }, optional: false, nullable: false
      field :translation, -> { String }, optional: true, nullable: true

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
