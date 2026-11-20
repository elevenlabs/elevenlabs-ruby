# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResellerTierResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'tier_id' => 'test-value', 'display_name' => 'test-value', 'tier_economics' => { 'monthly_price_usd' => 1, 'annual_price_usd' => 1, 'included_minutes_per_month' => 1, 'overage_price_per_minute_usd' => 1, 'max_phone_numbers' => 1, 'concurrent_calls' => 1, 'max_active_locations' => 1, 'max_customer_facing_agents' => 1, 'max_team_members' => 1, 'assistant_daily_messages' => 1 } }

    instance = ::Elevenlabs::Types::ResellerTierResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
