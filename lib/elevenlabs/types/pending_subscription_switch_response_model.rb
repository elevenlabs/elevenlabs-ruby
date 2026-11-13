# frozen_string_literal: true

module Elevenlabs
  module Types
    class PendingSubscriptionSwitchResponseModel < ::Elevenlabs::Internal::Types::Model
      field :kind, -> { ::Elevenlabs::Types::PendingSubscriptionSwitchResponseModelKind }, optional: true, nullable: false
      field :next_tier, -> { ::Elevenlabs::Types::PendingSubscriptionSwitchResponseModelNextTier }, optional: false, nullable: false
      field :next_billing_period, -> { ::Elevenlabs::Types::BillingPeriod }, optional: false, nullable: false
      field :timestamp_seconds, -> { Integer }, optional: false, nullable: false

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
