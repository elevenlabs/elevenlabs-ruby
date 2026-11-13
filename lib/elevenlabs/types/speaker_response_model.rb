# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeakerResponseModel < ::Elevenlabs::Internal::Types::Model
      field :speaker_id, -> { String }, optional: false, nullable: false
      field :duration_secs, -> { Float }, optional: false, nullable: false
      field :utterances, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::UtteranceResponseModel] }, optional: true, nullable: true

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
