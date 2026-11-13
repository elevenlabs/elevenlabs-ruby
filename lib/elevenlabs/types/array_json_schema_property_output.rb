# frozen_string_literal: true

module Elevenlabs
  module Types
    class ArrayJSONSchemaPropertyOutput < ::Elevenlabs::Internal::Types::Model
      field :description, -> { String }, optional: true, nullable: false
      field :dynamic_variable, -> { String }, optional: true, nullable: false
      field :constant_value, -> { ::Elevenlabs::Internal::Types::Array[Object] }, optional: true, nullable: true
      field :is_omitted, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :type, -> { ::Elevenlabs::Types::ArrayJSONSchemaPropertyOutputType }, optional: true, nullable: false
      field :items, -> { ::Elevenlabs::Types::ArrayJSONSchemaPropertyOutputItems }, optional: true, nullable: false

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
