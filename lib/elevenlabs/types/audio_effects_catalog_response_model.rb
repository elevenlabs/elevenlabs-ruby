# frozen_string_literal: true

module Elevenlabs
  module Types
    class AudioEffectsCatalogResponseModel < ::Elevenlabs::Internal::Types::Model
      field :filter_presets, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioEffectsFilterPresetResponseModel] }, optional: false, nullable: false
      field :environments, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioEffectsEnvironmentResponseModel] }, optional: false, nullable: false
      field :background_noises, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::AudioEffectsBackgroundNoiseResponseModel] }, optional: false, nullable: false

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
