# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OrbAvatarTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'orb', 'color_1' => 'test-value', 'color_2' => 'test-value' }

    instance = ::Elevenlabs::Types::OrbAvatar.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
