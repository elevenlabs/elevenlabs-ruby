# frozen_string_literal: true

module Elevenlabs
  module Types
    class LiteralJSONSchemaProperty < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::LiteralJSONSchemaPropertyType }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :enum, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: true
      field :is_system_provided, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :dynamic_variable, -> { String }, optional: true, nullable: false
      field :allowed_values, -> { ::Elevenlabs::Types::AllowedValues }, optional: true, nullable: true
      field :allowed_values_dynamic_variable, -> { String }, optional: true, nullable: false
      field :constant_value, -> { ::Elevenlabs::Types::LiteralJSONSchemaPropertyConstantValue }, optional: true, nullable: true
      field :is_omitted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

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
