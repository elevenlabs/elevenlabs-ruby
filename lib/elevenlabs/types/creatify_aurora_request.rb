# frozen_string_literal: true

module Elevenlabs
  module Types
    class CreatifyAuroraRequest < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: true
      field :model_id, -> { ::Elevenlabs::Types::CreatifyAuroraRequestModelID }, optional: false, nullable: false
      field :image, -> { ::Elevenlabs::Types::ImageReference }, optional: false, nullable: false
      field :audio, -> { ::Elevenlabs::Types::AudioReference }, optional: false, nullable: false
      field :resolution, -> { ::Elevenlabs::Types::CreatifyAuroraRequestResolution }, optional: true, nullable: false
      field :guidance_scale, -> { Float }, optional: true, nullable: true
      field :audio_guidance_scale, -> { Float }, optional: true, nullable: true

      def validate!
        Validator.validate_number!(guidance_scale, 'guidance_scale', min: 0, max: 5)
        Validator.validate_number!(audio_guidance_scale, 'audio_guidance_scale', min: 0, max: 5)
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
