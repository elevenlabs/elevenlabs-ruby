# frozen_string_literal: true

module Elevenlabs
  module Types
    class ResellerWorkspaceSubscription < ::Elevenlabs::Internal::Types::Model
      field :tier_id, -> { String }, optional: false, nullable: false
      field :billing_period, -> { ::Elevenlabs::Types::ResellerWorkspaceSubscriptionBillingPeriod }, optional: false, nullable: true
      field :billing_period_end_unix, -> { Integer }, optional: false, nullable: false
      field :cancel_at_unix, -> { Integer }, optional: true, nullable: true
      field :pending_downgrade_tier, -> { String }, optional: true, nullable: true
      field :pending_downgrade_at_unix, -> { Integer }, optional: true, nullable: true

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
