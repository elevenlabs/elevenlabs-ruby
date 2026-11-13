# frozen_string_literal: true

module Elevenlabs
  module Types
    class QueryParamsJSONSchemaInput < ::Elevenlabs::Internal::Types::Model
      field :properties, -> { ::Elevenlabs::Internal::Types::Hash[String, ::Elevenlabs::Types::LiteralJSONSchemaProperty] }, optional: false, nullable: false
      field :required, -> { ::Elevenlabs::Internal::Types::Array[String] }, optional: true, nullable: false

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
