# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionServiceVariant < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: true, nullable: false
      field :duration_minutes, -> { Integer }, optional: false, nullable: false
      field :price, -> { Float }, optional: true, nullable: true
      field :is_active, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(duration_minutes, 'duration_minutes', max: 43_200)
        Validator.validate_number!(price, 'price', min: 0)
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
