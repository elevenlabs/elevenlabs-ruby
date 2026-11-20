# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionServicePromotionTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'name' => 'test-value', 'target' => 'service', 'variant_id' => 'test-value', 'add_on_id' => 'test-value', 'promotional_price' => 0, 'days_of_week' => [0], 'start_date' => 'test-value', 'end_date' => 'test-value', 'is_active' => true }

    instance = ::Elevenlabs::Types::ReceptionServicePromotion.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
