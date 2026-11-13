# frozen_string_literal: true

module Elevenlabs
  module Types
    module ContentSchema
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::ArraySchema }, key: 'array'
      member -> { ::Elevenlabs::Types::AudioSchema }, key: 'audio'
      member -> { ::Elevenlabs::Types::BooleanSchema }, key: 'boolean'
      member -> { ::Elevenlabs::Types::ImageSchema }, key: 'image'
      member -> { ::Elevenlabs::Types::IntegerSchema }, key: 'integer'
      member -> { ::Elevenlabs::Types::NumberSchema }, key: 'number'
      member -> { ::Elevenlabs::Types::ObjectSchema }, key: 'object'
      member -> { ::Elevenlabs::Types::StringSchema }, key: 'string'
      member -> { ::Elevenlabs::Types::VideoSchema }, key: 'video'
      member -> { ::Elevenlabs::Types::VoiceSchema }, key: 'voice'

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
