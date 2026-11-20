# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SubscriptionUsageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'rollover_credits_quota' => 1, 'subscription_cycle_credits_quota' => 1, 'manually_gifted_credits_quota' => 1, 'payg_credits_quota' => 1, 'rollover_credits_used' => 1, 'subscription_cycle_credits_used' => 1, 'manually_gifted_credits_used' => 1, 'payg_credits_used' => 1, 'paid_usage_based_credits_used' => 1, 'actual_reported_credits' => 1 }

    instance = ::Elevenlabs::Types::SubscriptionUsageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
