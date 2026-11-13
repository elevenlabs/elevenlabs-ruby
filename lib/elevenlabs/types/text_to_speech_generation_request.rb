# frozen_string_literal: true

module Elevenlabs
  module Types
    module TextToSpeechGenerationRequest
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :model_id
      member -> { ::Elevenlabs::Types::ElevenFlashV25Request }, key: 'eleven_flash_v2_5'
      member -> { ::Elevenlabs::Types::ElevenMultilingualV2Request }, key: 'eleven_multilingual_v2'
      member -> { ::Elevenlabs::Types::ElevenV3Request }, key: 'eleven_v3'

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
