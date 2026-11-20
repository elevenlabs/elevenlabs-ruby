# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WidgetStylesTest < Minitest::Test
  def test_round_trip
    wire = { 'base' => 'test-value', 'base_hover' => 'test-value', 'base_active' => 'test-value', 'base_border' => 'test-value', 'base_subtle' => 'test-value', 'base_primary' => 'test-value', 'base_error' => 'test-value', 'accent' => 'test-value', 'accent_hover' => 'test-value', 'accent_active' => 'test-value', 'accent_border' => 'test-value', 'accent_subtle' => 'test-value', 'accent_primary' => 'test-value', 'overlay_padding' => 1, 'button_radius' => 1, 'input_radius' => 1, 'bubble_radius' => 1, 'sheet_radius' => 1, 'compact_sheet_radius' => 1, 'dropdown_sheet_radius' => 1 }

    instance = ::Elevenlabs::Types::WidgetStyles.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
