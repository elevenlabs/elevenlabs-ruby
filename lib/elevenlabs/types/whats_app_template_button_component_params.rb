# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppTemplateButtonComponentParams < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::WhatsAppTemplateButtonComponentParamsType }, optional: true, nullable: false
      field :parameters, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WhatsAppTemplateTextParam] }, optional: false, nullable: false
      field :index, -> { Integer }, optional: false, nullable: false
      field :sub_type, -> { String }, optional: false, nullable: false

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
