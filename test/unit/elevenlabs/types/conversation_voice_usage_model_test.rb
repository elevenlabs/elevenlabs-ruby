# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationVoiceUsageModelTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_id' => 'test-value', 'audio_output_seconds' => 1 }

    instance = ::Elevenlabs::Types::ConversationVoiceUsageModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
