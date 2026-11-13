# frozen_string_literal: true

module Elevenlabs
  module Types
    class Veo31FastRequest < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false
      field :negative_prompt, -> { String }, optional: true, nullable: true
      field :seed, -> { Integer }, optional: true, nullable: true
      field :enhance_prompt, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :duration_secs, -> { ::Elevenlabs::Types::Veo31FastRequestDurationSecs }, optional: true, nullable: false
      field :aspect_ratio, -> { ::Elevenlabs::Types::Veo31FastRequestAspectRatio }, optional: true, nullable: false
      field :resolution, -> { ::Elevenlabs::Types::Veo31FastRequestResolution }, optional: true, nullable: false
      field :generate_audio, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :start_frame, -> { ::Elevenlabs::Types::ImageReference }, optional: true, nullable: false
      field :end_frame, -> { ::Elevenlabs::Types::ImageReference }, optional: true, nullable: false
      field :images, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::VeoImageReference] }, optional: true, nullable: false
      field :model_id, -> { ::Elevenlabs::Types::Veo31FastRequestModelID }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(images, 'images', max_items: 3)
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
