# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingTargetTranscriptResponse < ::Elevenlabs::Internal::Types::Model
      field :source_language, -> { String }, optional: true, nullable: true
      field :target_language, -> { String }, optional: false, nullable: false
      field :segments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DubbingTargetTranscriptSegment] }, optional: false, nullable: false
      field :revision, -> { Integer }, optional: false, nullable: false

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
