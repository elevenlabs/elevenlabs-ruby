# frozen_string_literal: true

module Elevenlabs
  module Types
    class BytedanceSeedance2MiniRequest < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false
      field :aspect_ratio, -> { ::Elevenlabs::Types::BytedanceSeedance2MiniRequestAspectRatio }, optional: true, nullable: false
      field :duration_secs, -> { Integer }, optional: true, nullable: false
      field :seed, -> { Integer }, optional: true, nullable: true
      field :generate_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :start_frame, -> { ::Elevenlabs::Types::ImageReference }, optional: true, nullable: false
      field :end_frame, -> { ::Elevenlabs::Types::ImageReference }, optional: true, nullable: false
      field :images, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ImageReference] }, optional: true, nullable: false
      field :videos, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VideoReference] }, optional: true, nullable: false
      field :audios, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioReference] }, optional: true, nullable: false
      field :model_id, -> { ::Elevenlabs::Types::BytedanceSeedance2MiniRequestModelID }, optional: false, nullable: false
      field :resolution, -> { ::Elevenlabs::Types::BytedanceSeedance2MiniRequestResolution }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(duration_secs, 'duration_secs', min: 4, max: 15)
        ::Elevenlabs::Validator.validate_array!(images, 'images', max_items: 9)
        ::Elevenlabs::Validator.validate_array!(videos, 'videos', max_items: 3)
        ::Elevenlabs::Validator.validate_array!(audios, 'audios', max_items: 3)
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
