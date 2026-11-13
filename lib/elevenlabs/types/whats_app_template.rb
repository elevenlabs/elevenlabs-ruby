# frozen_string_literal: true

module Elevenlabs
  module Types
    class WhatsAppTemplate < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false
      field :language, -> { String }, optional: false, nullable: false
      field :parameter_format, -> { ::Elevenlabs::Types::WhatsAppTemplateParameterFormat }, optional: true, nullable: false
      field :components, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::WhatsAppTemplateComponent] }, optional: false, nullable: false
      field :category, -> { String }, optional: true, nullable: true

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
