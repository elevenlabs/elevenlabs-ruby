# frozen_string_literal: true

module Elevenlabs
  module Types
    class ObjectJSONSchemaPropertyInput < ::Elevenlabs::Internal::Types::Model
      field :property_kind, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyInputPropertyKind }, optional: true, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :dynamic_variable, -> { String }, optional: true, nullable: false
      field :constant_value, -> { Object }, optional: true, nullable: true
      field :is_omitted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ObjectJSONSchemaPropertyInputType }, optional: true, nullable: false
      field :required, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false
      field :properties, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Agents::Types::ObjectJSONSchemaPropertyInputPropertiesValue] }, optional: true, nullable: false
      field :required_constraints, -> { ::Elevenlabs::Types::RequiredConstraints }, optional: true, nullable: true

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
