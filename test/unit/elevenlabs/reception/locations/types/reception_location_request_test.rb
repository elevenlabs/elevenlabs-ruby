# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionLocationRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'address' => 'test-value', 'notes' => 'test-value', 'operating_hours' => { 'hours' => { 'key' => [{ 'start_hour' => 0, 'start_minute' => 0, 'end_hour' => 0, 'end_minute' => 0 }] }, 'timezone' => 'test-value' }, 'customer_facing_name' => 'test-value', 'max_concurrent_appointments' => 1, 'is_active' => true }

    instance = ::Elevenlabs::Reception::Locations::Types::ReceptionLocationRequest.new(wire)

    assert_equal(wire, instance.to_h.except('xi-workspace-id'))
  end
end
