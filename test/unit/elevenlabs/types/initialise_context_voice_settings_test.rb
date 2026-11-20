# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InitialiseContextVoiceSettingsTest < Minitest::Test
  def test_round_trip
    wire = { 'stability' => 1, 'similarity_boost' => 1, 'style' => 1, 'use_speaker_boost' => true, 'speed' => 1 }

    instance = ::Elevenlabs::Types::InitialiseContextVoiceSettings.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
