# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class StudioTextStyleShadowModelTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'color' => 'test-value', 'opacity' => 1, 'blur' => 1, 'offset_x' => 1, 'offset_y' => 1 }

    instance = ::Elevenlabs::Types::StudioTextStyleShadowModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
