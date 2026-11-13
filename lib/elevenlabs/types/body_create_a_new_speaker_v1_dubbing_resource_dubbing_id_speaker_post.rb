# frozen_string_literal: true

module Elevenlabs
  module Types
    class BodyCreateANewSpeakerV1DubbingResourceDubbingIDSpeakerPost < ::Elevenlabs::Internal::Types::Model
      field :speaker_name, -> { String }, optional: true, nullable: true
      field :voice_id, -> { String }, optional: true, nullable: true
      field :voice_stability, -> { Float }, optional: true, nullable: true
      field :voice_similarity, -> { Float }, optional: true, nullable: true
      field :voice_style, -> { Float }, optional: true, nullable: true

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
