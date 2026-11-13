# frozen_string_literal: true

module Elevenlabs
  module Types
    class SubscriptionUsageResponseModel < ::Elevenlabs::Internal::Types::Model
      field :rollover_credits_quota, -> { Integer }, optional: false, nullable: false
      field :subscription_cycle_credits_quota, -> { Integer }, optional: false, nullable: false
      field :manually_gifted_credits_quota, -> { Integer }, optional: false, nullable: false
      field :payg_credits_quota, -> { Integer }, optional: true, nullable: true
      field :rollover_credits_used, -> { Integer }, optional: false, nullable: false
      field :subscription_cycle_credits_used, -> { Integer }, optional: false, nullable: false
      field :manually_gifted_credits_used, -> { Integer }, optional: false, nullable: false
      field :payg_credits_used, -> { Integer }, optional: true, nullable: true
      field :paid_usage_based_credits_used, -> { Integer }, optional: false, nullable: false
      field :actual_reported_credits, -> { Integer }, optional: false, nullable: false

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
