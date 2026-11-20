# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentHoldAudioConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'audio_path' => 'test-value', 'audio_url' => 'test-value', 'original_filename' => 'test-value', 'duration_secs' => 1, 'size_bytes' => 1 }

    instance = ::Elevenlabs::Types::AgentHoldAudioConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
