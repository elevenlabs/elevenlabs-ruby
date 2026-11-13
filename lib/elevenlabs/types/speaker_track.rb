# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeakerTrack < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :media_ref, -> { ::Elevenlabs::Types::DubbingMediaReference }, optional: false, nullable: false
      field :speaker_name, -> { String }, optional: false, nullable: false
      field :voices, -> { ::Elevenlabs::Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :segments, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: false, nullable: false

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
