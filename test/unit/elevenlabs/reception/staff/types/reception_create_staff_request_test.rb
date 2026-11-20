# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionCreateStaffRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'groups' => [{ 'label' => 'test-value', 'rank' => 0 }], 'ungrouped_rank' => 0, 'name' => 'test-value', 'description' => 'test-value', 'is_active' => true, 'email' => 'test-value', 'phone' => 'test-value', 'sms_notifications_opted_in' => true, 'photo_url' => 'test-value', 'location_id' => 'test-value', 'working_hours' => { 'hours' => { 'key' => [{ 'start_hour' => 0, 'start_minute' => 0, 'end_hour' => 0, 'end_minute' => 0 }] }, 'timezone' => 'test-value' }, 'display_on_booking_page' => true, 'customer_facing_name' => 'test-value' }

    instance = ::Elevenlabs::Reception::Staff::Types::ReceptionCreateStaffRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
