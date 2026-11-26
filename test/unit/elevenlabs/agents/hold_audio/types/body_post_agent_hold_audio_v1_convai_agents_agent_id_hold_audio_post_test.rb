# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyPostAgentHoldAudioV1ConvaiAgentsAgentIDHoldAudioPostTest < Minitest::Test
  def test_round_trip
    wire = { 'hold_audio_file' => 'test-value' }

    instance = ::Elevenlabs::Agents::HoldAudio::Types::BodyPostAgentHoldAudioV1ConvaiAgentsAgentIDHoldAudioPost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id'))
  end
end
