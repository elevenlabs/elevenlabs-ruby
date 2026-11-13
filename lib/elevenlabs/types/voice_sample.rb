# frozen_string_literal: true

module Elevenlabs
  module Types
    class VoiceSample < ::Elevenlabs::Internal::Types::Model
      field :sample_id, -> { String }, optional: true, nullable: false
      field :file_name, -> { String }, optional: true, nullable: false
      field :mime_type, -> { String }, optional: true, nullable: false
      field :size_bytes, -> { Integer }, optional: true, nullable: false
      field :hash_, -> { String }, optional: true, nullable: false, api_name: 'hash'
      field :duration_secs, -> { Float }, optional: true, nullable: true
      field :remove_background_noise, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :has_isolated_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :has_isolated_audio_preview, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: true
      field :speaker_separation, -> { ::Elevenlabs::Types::SpeakerSeparationResponseModel }, optional: true, nullable: true
      field :trim_start, -> { Integer }, optional: true, nullable: true
      field :trim_end, -> { Integer }, optional: true, nullable: true

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
