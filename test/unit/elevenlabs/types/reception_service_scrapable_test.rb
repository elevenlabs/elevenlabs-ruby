# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionServiceScrapableTest < Minitest::Test
  def test_round_trip
    wire = { 'pricing_mode' => 'fixed', 'groups' => [{ 'label' => 'test-value', 'rank' => 0 }], 'ungrouped_rank' => 0, 'name' => 'test-value', 'description' => 'test-value', 'variants' => [{ 'id' => 'test-value', 'duration_minutes' => 43_200, 'price' => 0, 'is_active' => true }], 'kind' => 'classic', 'buffer_minutes' => 0, 'service_location' => 'business', 'add_ons' => [{ 'id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value', 'add_duration_minutes' => 0, 'add_price' => 0 }], 'max_participants' => 2 }

    instance = ::Elevenlabs::Types::ReceptionServiceScrapable.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
