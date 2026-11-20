# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionAssetResourceTest < Minitest::Test
  def test_round_trip
    wire = { 'groups' => [{ 'label' => 'test-value', 'rank' => 0 }], 'ungrouped_rank' => 0, 'name' => 'test-value', 'description' => 'test-value', 'is_active' => true, 'available_hours' => { 'hours' => { 'key' => [{ 'start_hour' => 0, 'start_minute' => 0, 'end_hour' => 0, 'end_minute' => 0 }] }, 'timezone' => 'test-value' }, 'photo_url' => 'test-value', 'location_id' => 'test-value', 'customer_facing_name' => 'test-value', 'id' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1 }

    instance = ::Elevenlabs::Types::ReceptionAssetResource.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
