# frozen_string_literal: true

module Elevenlabs
  module Types
    class ConstantSchemaOverride < ::Elevenlabs::Internal::Types::Model
      field :source, -> { ::Elevenlabs::Types::ConstantSchemaOverrideSource }, optional: true, nullable: false
      field :constant_value, -> { ::Elevenlabs::Types::ConstantSchemaOverrideConstantValue }, optional: false, nullable: true

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
