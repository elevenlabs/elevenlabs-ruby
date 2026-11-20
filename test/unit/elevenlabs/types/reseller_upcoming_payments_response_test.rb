# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResellerUpcomingPaymentsResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'payments' => [{ 'workspace_id' => 'test-value', 'workspace_name' => 'test-value', 'subscription' => { 'tier_id' => 'test-value', 'billing_period' => 'monthly_period', 'billing_period_end_unix' => 1, 'cancel_at_unix' => 1, 'pending_downgrade_tier' => 'test-value', 'pending_downgrade_at_unix' => 1 }, 'plan_usd' => 1, 'overage_so_far_usd' => 1 }] }

    instance = ::Elevenlabs::Types::ResellerUpcomingPaymentsResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
