# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OrderResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'order_id' => 'test-value', 'name' => 'test-value', 'state' => 'open', 'items' => [{ 'item_id' => 'test-value', 'item' => { 'kind' => 'dub', 'media_id' => 'test-value', 'source_language' => 'test-value', 'destination_languages' => ['test-value'], 'include_captions' => true, 'include_source_captions' => true, 'instructions' => 'test-value', 'captions_sdh' => true }, 'quote' => { 'amount_usd' => 1 } }], 'total_amount_usd' => 1, 'sandbox' => true, 'created_at' => 'test-value', 'submitted_at' => 'test-value', 'paid_at' => 'test-value', 'accepted_at' => 'test-value', 'completed_at' => 'test-value', 'cancel_reason' => 'test-value' }

    instance = ::Elevenlabs::Types::OrderResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
