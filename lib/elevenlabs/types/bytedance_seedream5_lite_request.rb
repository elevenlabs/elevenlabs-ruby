# frozen_string_literal: true

module Elevenlabs
  module Types
    class BytedanceSeedream5LiteRequest < ::Elevenlabs::Internal::Types::Model
      field :webhook, -> { ::Elevenlabs::Types::WebhookTarget }, optional: true, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false
      field :images, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ImageReference] }, optional: true, nullable: false
      field :aspect_ratio, -> { ::Elevenlabs::Types::BytedanceSeedream5LiteRequestAspectRatio }, optional: true, nullable: false
      field :seed, -> { Integer }, optional: true, nullable: true
      field :model_id, -> { ::Elevenlabs::Types::BytedanceSeedream5LiteRequestModelID }, optional: false, nullable: false
      field :resolution, -> { ::Elevenlabs::Types::BytedanceSeedream5LiteRequestResolution }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(images, 'images', max_items: 10)
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
