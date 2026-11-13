# frozen_string_literal: true

module Elevenlabs
  module Types
    module TemplateOutput
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::TemplateArrayOutput }, key: 'array'
      member -> { ::Elevenlabs::Types::TemplateAudioOutput }, key: 'audio'
      member -> { ::Elevenlabs::Types::TemplateBooleanOutput }, key: 'boolean'
      member -> { ::Elevenlabs::Types::TemplateImageOutput }, key: 'image'
      member -> { ::Elevenlabs::Types::TemplateIntegerOutput }, key: 'integer'
      member -> { ::Elevenlabs::Types::TemplateNumberOutput }, key: 'number'
      member -> { ::Elevenlabs::Types::TemplateObjectOutput }, key: 'object'
      member -> { ::Elevenlabs::Types::TemplateStringOutput }, key: 'string'
      member -> { ::Elevenlabs::Types::TemplateVideoOutput }, key: 'video'

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
