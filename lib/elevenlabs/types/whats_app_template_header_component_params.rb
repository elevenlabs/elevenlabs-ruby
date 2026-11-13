# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppTemplateHeaderComponentParams < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WhatsAppTemplateHeaderComponentParamsType }, optional: true, nullable: false
      field :parameters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WhatsAppTemplateHeaderComponentParamsParametersItem] }, optional: false, nullable: false

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
