# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateOrderV1ProductionsOrdersOrderIDPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'request' => { 'name' => 'test-value' } }

    instance = ::Elevenlabs::Productions::Orders::Types::BodyUpdateOrderV1ProductionsOrdersOrderIDPatch.new(wire)

    assert_equal(wire, instance.to_h.except('order_id'))
  end
end
