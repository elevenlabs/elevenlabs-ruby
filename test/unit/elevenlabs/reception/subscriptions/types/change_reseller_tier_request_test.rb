# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ChangeResellerTierRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'tier_id' => 'test-value', 'billing_period' => 'monthly_period', 'idempotency_key' => 'test-value' }

    instance = ::Elevenlabs::Reception::Subscriptions::Types::ChangeResellerTierRequest.new(wire)

    assert_equal(wire, instance.to_h.except('workspace_id'))
  end
end
