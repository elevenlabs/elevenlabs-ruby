# frozen_string_literal: true

module Elevenlabs
  module Types
    module TemplateInputReference
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::StaticAssetReference }, key: 'asset'
      member -> { ::Elevenlabs::Types::GenerationReference }, key: 'generation'
      member -> { ::Elevenlabs::Types::InlineBase64Reference }, key: 'inline_base64'
      member -> { ::Elevenlabs::Types::VoiceReference }, key: 'voice'

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
