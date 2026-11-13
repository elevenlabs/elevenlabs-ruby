# frozen_string_literal: true

module Elevenlabs
  module Types
    class SpeakerSeparationResponseModel < ::Elevenlabs::Internal::Types::Model
      field :voice_id, -> { String }, optional: false, nullable: false
      field :sample_id, -> { String }, optional: false, nullable: false
      field :status, -> { ::Elevenlabs::Types::SpeakerSeparationResponseModelStatus }, optional: false, nullable: false
      field :speakers, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::SpeakerResponseModel] }, optional: true, nullable: true
      field :selected_speaker_ids, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true

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
