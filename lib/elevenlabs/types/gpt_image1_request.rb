# frozen_string_literal: true

module Elevenlabs
  module Types
    class GptImage1Request < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false
      field :images, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ImageReference] }, optional: true, nullable: false
      field :mask, -> { ::Elevenlabs::Types::ImageReference }, optional: true, nullable: false
      field :quality, -> { ::Elevenlabs::Types::GptImage1RequestQuality }, optional: true, nullable: false
      field :background, -> { ::Elevenlabs::Types::GptImage1RequestBackground }, optional: true, nullable: false
      field :aspect_ratio, -> { ::Elevenlabs::Types::GptImage1RequestAspectRatio }, optional: true, nullable: false
      field :model_id, -> { ::Elevenlabs::Types::GptImage1RequestModelID }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(images, 'images', max_items: 5)
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
