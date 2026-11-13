# frozen_string_literal: true

module Elevenlabs
  module Types
    class DubbingResource < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :version, -> { Integer }, optional: false, nullable: false
      field :source_language, -> { String }, optional: false, nullable: false
      field :target_languages, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false
      field :input, -> { ::Elevenlabs::Types::DubbingMediaReference }, optional: false, nullable: false
      field :background, -> { ::Elevenlabs::Types::DubbingMediaReference }, optional: false, nullable: false
      field :foreground, -> { ::Elevenlabs::Types::DubbingMediaReference }, optional: false, nullable: false
      field :speaker_tracks, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::SpeakerTrack] }, optional: false, nullable: false
      field :speaker_segments, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::SpeakerSegment] }, optional: false, nullable: false
      field :renders, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::Render] }, optional: false, nullable: false

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
