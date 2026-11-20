# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CanvasPlacementTest < Minitest::Test
  def test_round_trip
    wire = { 'x_relative' => 1, 'y_relative' => 1, 'scale_x' => 1, 'scale_y' => 1, 'pivot_x' => 1, 'pivot_y' => 1, 'skew_x' => 1, 'skew_y' => 1, 'crop_top' => 1, 'crop_right' => 1, 'crop_bottom' => 1, 'crop_left' => 1, 'flip_x' => true, 'flip_y' => true }

    instance = ::Elevenlabs::Types::CanvasPlacement.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
