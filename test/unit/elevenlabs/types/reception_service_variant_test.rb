# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionServiceVariantTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'duration_minutes' => 43_200, 'price' => 0, 'is_active' => true }

    instance = ::Elevenlabs::Types::ReceptionServiceVariant.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
