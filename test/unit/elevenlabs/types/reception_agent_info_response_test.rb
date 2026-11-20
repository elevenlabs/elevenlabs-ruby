# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionAgentInfoResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'business_name' => 'test-value', 'business_country' => 'test-value', 'business_description' => 'test-value', 'timezone' => 'test-value', 'currency' => 'USD', 'operating_hours' => { 'hours' => { 'key' => [{ 'start_hour' => 0, 'start_minute' => 0, 'end_hour' => 0, 'end_minute' => 0 }] }, 'timezone' => 'test-value' }, 'tool_call_sound' => 'typing', 'id' => 'test-value', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'workspace_now' => { 'today' => { 'year' => 2026, 'month' => 1, 'day' => 1 }, 'hour' => 0, 'minute' => 0, 'fetched_at_ms' => 1 } }

    instance = ::Elevenlabs::Types::ReceptionAgentInfoResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
