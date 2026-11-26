# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionUpdateServiceRequestPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'pricing_mode' => 'fixed', 'intake_questions' => [{ 'id' => 'test-value', 'label' => 'test-value', 'kind' => 'text', 'options' => ['test-value'], 'required' => true, 'is_active' => true }], 'groups' => [{ 'label' => 'test-value', 'rank' => 0 }], 'ungrouped_rank' => 1, 'name' => 'test-value', 'description' => 'test-value', 'variants' => [{ 'id' => 'test-value', 'duration_minutes' => 43_200, 'price' => 0, 'is_active' => true }], 'kind' => 'classic', 'buffer_minutes' => 1, 'service_location' => 'business', 'add_ons' => [{ 'id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value', 'add_duration_minutes' => 0, 'add_price' => 0 }], 'max_participants' => 2, 'capacity' => 1, 'is_active' => true, 'any_staff_member' => true, 'staff_ids' => ['test-value'], 'asset_ids' => ['test-value'], 'advance_booking_minutes' => 1, 'location_ids' => ['test-value'], 'display_on_booking_page' => true, 'travel_minutes' => 1, 'travel_before' => true, 'travel_after' => true, 'promotions' => [{ 'id' => 'test-value', 'name' => 'test-value', 'target' => 'service', 'variant_id' => 'test-value', 'add_on_id' => 'test-value', 'promotional_price' => 0, 'days_of_week' => [0], 'start_date' => 'test-value', 'end_date' => 'test-value', 'is_active' => true }], 'duration_minutes' => 43_200, 'price' => 0 }

    instance = ::Elevenlabs::Reception::Services::Types::ReceptionUpdateServiceRequestPatch.new(wire)

    assert_equal(wire, instance.to_h.except('service_id', 'xi-workspace-id'))
  end
end
