# frozen_string_literal: true

module Elevenlabs
  module Types
    class ProvisionResellerWorkspaceSubscription < ::Elevenlabs::Internal::Types::Model
      field :tier_id, -> { String }, optional: false, nullable: false
      field :billing_period, -> { ::Elevenlabs::Types::ProvisionResellerWorkspaceSubscriptionBillingPeriod }, optional: true, nullable: false

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
