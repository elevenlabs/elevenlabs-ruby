# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CheckServiceAvailabilityParamsTest < Minitest::Test
  def test_round_trip
    wire = { 'smb_tool_type' => 'check_service_availability' }

    instance = ::Elevenlabs::Types::CheckServiceAvailabilityParams.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
