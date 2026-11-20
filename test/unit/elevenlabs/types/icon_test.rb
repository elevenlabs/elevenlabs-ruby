# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class IconTest < Minitest::Test
  def test_round_trip
    wire = { 'src' => 'test-value', 'mimeType' => 'test-value', 'sizes' => ['test-value'], 'theme' => 'light' }

    instance = ::Elevenlabs::Types::Icon.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
