# frozen_string_literal: true

module Elevenlabs
  module Types
    module InvoiceResponsePaymentIntentStatussesItem
      extend ::Elevenlabs::Internal::Types::Enum

      CANCELED = :canceled
      PROCESSING = :processing
      REQUIRES_ACTION = :requires_action
      REQUIRES_CAPTURE = :requires_capture
      REQUIRES_CONFIRMATION = :requires_confirmation
      REQUIRES_PAYMENT_METHOD = :requires_payment_method
      SUCCEEDED = :succeeded

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
