# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RegionConfigRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'region_id' => 'us1', 'token' => 'test-value', 'edge_location' => 'ashburn' }

    instance = ::Elevenlabs::Types::RegionConfigRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
