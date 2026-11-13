# frozen_string_literal: true

module Elevenlabs
  module Types
    class LlmObjectJSONSchemaPropertyInput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::LlmObjectJSONSchemaPropertyInputType }, optional: true, nullable: false
      field :required, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :properties, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LlmObjectJSONSchemaPropertyInputPropertiesValue] }, optional: true, nullable: false

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
