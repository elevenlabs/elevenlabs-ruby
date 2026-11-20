# frozen_string_literal: true

module Elevenlabs
  module Types
    class ReceptionAddOn < ::Elevenlabs::Internal::Types::Model
      field :id, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :description, -> { String }, optional: true, nullable: false
      field :add_duration_minutes, -> { Integer }, optional: true, nullable: false
      field :add_price, -> { Float }, optional: true, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_integer!(add_duration_minutes, 'add_duration_minutes', min: 0, max: 43_200)
        Validator.validate_number!(add_price, 'add_price', min: 0)
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
