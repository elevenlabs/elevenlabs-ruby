# frozen_string_literal: true

module Elevenlabs
  module Types
    class AstllmNodeOutput < ::Elevenlabs::Internal::Types::Model
      field :type, -> { ::Elevenlabs::Types::AstllmNodeOutputType }, optional: false, nullable: false
      field :value_schema, -> { ::Elevenlabs::Types::LlmLiteralJSONSchemaProperty }, optional: false, nullable: false
      field :prompt, -> { String }, optional: false, nullable: false

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
