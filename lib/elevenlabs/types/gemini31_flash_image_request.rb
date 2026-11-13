# frozen_string_literal: true

module Elevenlabs
  module Types
    class Gemini31FlashImageRequest < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false
      field :model_id, -> { ::Elevenlabs::Types::Gemini31FlashImageRequestModelID }, optional: false, nullable: false
      field :images, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ImageReference] }, optional: true, nullable: false
      field :aspect_ratio, -> { ::Elevenlabs::Types::Gemini31FlashImageRequestAspectRatio }, optional: true, nullable: false
      field :resolution, -> { ::Elevenlabs::Types::Gemini31FlashImageRequestResolution }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(images, 'images', max_items: 14)
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
