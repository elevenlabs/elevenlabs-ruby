# frozen_string_literal: true

module Elevenlabs
  module Types
    module WhatsAppTemplateHeaderComponentParamsParametersItem
      extend ::Elevenlabs::Internal::Types::Union

      discriminant :type
      member -> { ::Elevenlabs::Types::WhatsAppTemplateDocumentParam }, key: 'document'
      member -> { ::Elevenlabs::Types::WhatsAppTemplateImageParam }, key: 'image'
      member -> { ::Elevenlabs::Types::WhatsAppTemplateLocationParam }, key: 'location'
      member -> { ::Elevenlabs::Types::WhatsAppTemplateTextParam }, key: 'text'

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
