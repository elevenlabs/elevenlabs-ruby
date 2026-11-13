# frozen_string_literal: true

module Elevenlabs
  module Types
    module ImageGenerationRequest
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :model_id
      member -> { ::Elevenlabs::Types::BytedanceSeedream5LiteRequest }, key: 'bytedance-seedream-5-lite'
      member -> { ::Elevenlabs::Types::BytedanceSeedream5ProRequest }, key: 'bytedance-seedream-5-pro'
      member -> { ::Elevenlabs::Types::Gemini25FlashImageRequest }, key: 'gemini-2.5-flash-image'
      member -> { ::Elevenlabs::Types::Gemini3ProImageRequest }, key: 'gemini-3-pro-image'
      member -> { ::Elevenlabs::Types::Gemini31FlashImageRequest }, key: 'gemini-3.1-flash-image'
      member -> { ::Elevenlabs::Types::Gemini31FlashLiteImageRequest }, key: 'gemini-3.1-flash-lite-image'
      member -> { ::Elevenlabs::Types::GptImage1Request }, key: 'gpt-image-1'
      member -> { ::Elevenlabs::Types::GptImage15Request }, key: 'gpt-image-1.5'
      member -> { ::Elevenlabs::Types::GptImage2Request }, key: 'gpt-image-2'
      member -> { ::Elevenlabs::Types::GptImage25FlareRequest }, key: 'gpt-image-2.5-flare'
      member -> { ::Elevenlabs::Types::GptImage25SunburstRequest }, key: 'gpt-image-2.5-sunburst'

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
