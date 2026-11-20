# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OrderSummaryTest < Minitest::Test
  def test_round_trip
    wire = { 'order_id' => 'test-value', 'name' => 'test-value', 'state' => 'open', 'total_amount_usd' => 1, 'sandbox' => true, 'submitted_at' => 'test-value', 'updated_at' => 'test-value', 'cancel_reason' => 'test-value' }

    instance = ::Elevenlabs::Types::OrderSummary.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
