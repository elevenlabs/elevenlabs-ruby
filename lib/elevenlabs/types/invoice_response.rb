# frozen_string_literal: true

module Elevenlabs
  module Types
    class InvoiceResponse < ::Elevenlabs::Internal::Types::Model
      field :amount_due_cents, -> { Integer }, optional: false, nullable: false
      field :subtotal_cents, -> { Integer }, optional: true, nullable: true
      field :tax_cents, -> { Integer }, optional: true, nullable: true
      field :discount_percent_off, -> { Float }, optional: true, nullable: true
      field :discount_amount_off, -> { Float }, optional: true, nullable: true
      field :discounts, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::DiscountResponseModel] }, optional: false, nullable: false
      field :next_payment_attempt_unix, -> { Integer }, optional: false, nullable: false
      field :payment_intent_status, -> { ::Elevenlabs::Types::InvoiceResponsePaymentIntentStatus }, optional: false, nullable: true
      field :payment_intent_statusses, -> { ::Elevenlabs::Internal::Types::Array[::Elevenlabs::Types::InvoiceResponsePaymentIntentStatussesItem] }, optional: false, nullable: false

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
