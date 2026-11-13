# frozen_string_literal: true

module Elevenlabs
  module Types
    class OrderResponse < ::Elevenlabs::Internal::Types::Model
      field :order_id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :state, -> { ::Elevenlabs::Types::OrderState }, optional: false, nullable: false
      field :items, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::OrderItemInfo] }, optional: false, nullable: false
      field :total_amount_usd, -> { Float }, optional: true, nullable: true
      field :sandbox, -> { ::Elevenlabs::Internal::Types::Boolean }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :submitted_at, -> { String }, optional: true, nullable: true
      field :paid_at, -> { String }, optional: true, nullable: true
      field :accepted_at, -> { String }, optional: true, nullable: true
      field :completed_at, -> { String }, optional: true, nullable: true
      field :cancel_reason, -> { String }, optional: true, nullable: true

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
