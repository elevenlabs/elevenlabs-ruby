# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ListOrdersResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'orders' => [{ 'order_id' => 'test-value', 'name' => 'test-value', 'state' => 'open', 'total_amount_usd' => 1, 'sandbox' => true, 'submitted_at' => 'test-value', 'updated_at' => 'test-value', 'cancel_reason' => 'test-value' }] }

    instance = ::Elevenlabs::Types::ListOrdersResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
