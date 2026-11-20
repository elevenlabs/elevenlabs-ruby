# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceSettingsTest < Minitest::Test
  def test_round_trip
    wire = { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }

    instance = ::Elevenlabs::Types::VoiceSettings.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
