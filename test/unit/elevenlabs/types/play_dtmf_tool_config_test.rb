# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PlayDtmfToolConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'system_tool_type' => 'play_keypad_touch_tone', 'use_out_of_band_dtmf' => true, 'suppress_turn_after_dtmf' => true }

    instance = ::Elevenlabs::Types::PlayDtmfToolConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
