# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResellerWorkspaceSummaryTest < Minitest::Test
  def test_round_trip
    wire = { 'workspace_id' => 'test-value', 'business_name' => 'test-value', 'billing_tier' => 'test-value', 'receptionist_count' => 1, 'calls_last_30_days' => 1, 'created_at_unix' => 1, 'subscription' => { 'tier_id' => 'test-value', 'billing_period' => 'monthly_period', 'billing_period_end_unix' => 1, 'cancel_at_unix' => 1, 'pending_downgrade_tier' => 'test-value', 'pending_downgrade_at_unix' => 1 }, 'has_payment_issue' => true, 'onboarding_completed_at_unix' => 1 }

    instance = ::Elevenlabs::Types::ResellerWorkspaceSummary.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
