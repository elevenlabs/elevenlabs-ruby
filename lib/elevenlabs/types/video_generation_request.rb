# frozen_string_literal: true

module Elevenlabs
  module Types
    module VideoGenerationRequest
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :model_id
      member -> { ::Elevenlabs::Types::BytedanceSeedance2Request }, key: 'bytedance-seedance-v2'
      member -> { ::Elevenlabs::Types::BytedanceSeedance2FastRequest }, key: 'bytedance-seedance-v2-fast'
      member -> { ::Elevenlabs::Types::BytedanceSeedance2MiniRequest }, key: 'bytedance-seedance-v2-mini'
      member -> { ::Elevenlabs::Types::BytedanceSeedance25Request }, key: 'bytedance-seedance-v2.5'
      member -> { ::Elevenlabs::Types::CreatifyAuroraRequest }, key: 'creatify-aurora'
      member -> { ::Elevenlabs::Types::Veo31FastRequest }, key: 'veo-3.1-fast-generate-001'
      member -> { ::Elevenlabs::Types::Veo31Request }, key: 'veo-3.1-generate-001'

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
