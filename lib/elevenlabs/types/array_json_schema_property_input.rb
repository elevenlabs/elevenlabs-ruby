# frozen_string_literal: true

module Elevenlabs
  module Types
    class ArrayJSONSchemaPropertyInput < ::Elevenlabs::Internal::Types::Model
      field :property_kind, -> { ::Elevenlabs::Types::ArrayJSONSchemaPropertyInputPropertyKind }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :dynamic_variable, -> { String }, optional: true, nullable: false
      field :constant_value, -> { ::Elevenlabs::Internal::Types::Array[Object] }, optional: true, nullable: true
      field :is_omitted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ArrayJSONSchemaPropertyInputType }, optional: true, nullable: false
      field :items, -> { ::Elevenlabs::Types::ArrayJSONSchemaPropertyInputItems }, optional: true, nullable: false

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
