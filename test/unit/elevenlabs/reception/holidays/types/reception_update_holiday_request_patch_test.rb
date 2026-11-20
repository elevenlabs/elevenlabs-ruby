# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionUpdateHolidayRequestPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'start_date' => { 'year' => 2026, 'month' => 1, 'day' => 1 }, 'end_date' => { 'year' => 2026, 'month' => 1, 'day' => 1 }, 'holiday_type' => 'closed', 'override_hours' => [{ 'start_hour' => 0, 'start_minute' => 0, 'end_hour' => 0, 'end_minute' => 0 }], 'time_off_type' => 'staff', 'resource_id' => 'test-value', 'location_id' => 'test-value', 'reason' => 'test-value' }

    instance = ::Elevenlabs::Reception::Holidays::Types::ReceptionUpdateHolidayRequestPatch.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
