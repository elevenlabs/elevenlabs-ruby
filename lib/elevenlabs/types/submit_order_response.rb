# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubmitOrderResponse < ::Elevenlabs::Internal::Types::Model
      field :order_id, -> { String }, optional: false, nullable: false
      field :state, -> { ::Elevenlabs::Types::OrderState }, optional: false, nullable: false
      field :submitted_at, -> { String }, optional: false, nullable: false

      def validate!
        ::Elevenlabs::Validator.validate_string!(order_id, 'order_id', pattern: /^prodorder_[a-z0-9]{26}$/)
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
