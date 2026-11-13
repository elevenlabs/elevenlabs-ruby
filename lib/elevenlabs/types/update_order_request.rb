# frozen_string_literal: true

module Elevenlabs
  module Types
    class UpdateOrderRequest < ::Elevenlabs::Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(name, 'name', min_length: 1, max_length: 120)
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
