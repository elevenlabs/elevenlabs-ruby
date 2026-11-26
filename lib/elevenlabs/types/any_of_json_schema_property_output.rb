# frozen_string_literal: true

module Elevenlabs
  module Types
    class AnyOfJSONSchemaPropertyOutput < ::Elevenlabs::Internal::Types::Model
      field :any_of, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::ObjectJSONSchemaPropertyOutput] }, optional: false, nullable: false
      field :discriminator, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_array!(any_of, 'any_of', min_items: 2)
        ::Elevenlabs::Validator.validate_string!(discriminator, 'discriminator', min_length: 1)
      end

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
