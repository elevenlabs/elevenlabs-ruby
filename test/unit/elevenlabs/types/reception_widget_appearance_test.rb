# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionWidgetAppearanceTest < Minitest::Test
  def test_round_trip
    wire = { 'orb_color_1' => 'test-value', 'orb_color_2' => 'test-value', 'variant' => 'tiny', 'placement' => 'top-left', 'dismissible' => true, 'main_label' => 'test-value', 'start_call' => 'test-value' }

    instance = ::Elevenlabs::Types::ReceptionWidgetAppearance.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
