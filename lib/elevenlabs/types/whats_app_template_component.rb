# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppTemplateComponent < ::Elevenlabs::Internal::Types::Model
      field :type, -> { String }, optional: false, nullable: false
      field :format, -> { String }, optional: true, nullable: true
      field :text, -> { String }, optional: true, nullable: true
      field :buttons, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WhatsAppTemplateComponentButton] }, optional: true, nullable: true

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
