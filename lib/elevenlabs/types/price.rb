# frozen_string_literal: true

module Elevenlabs
  module Types
    class Price < ::Elevenlabs::Internal::Types::Model
      field :amount, -> { String }, optional: false, nullable: false
      field :currency, -> { ::Elevenlabs::Types::Currency }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(amount, 'amount', pattern: /^(?!^[-+.]*$)[+-]?0*\d*\.?\d*$/)
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
