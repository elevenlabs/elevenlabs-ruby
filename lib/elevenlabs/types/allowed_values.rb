# frozen_string_literal: true

module Elevenlabs
  module Types
    class AllowedValues < ::Elevenlabs::Internal::Types::Model
      field :dynamic_variable, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(dynamic_variable, 'dynamic_variable', min_length: 1)
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
