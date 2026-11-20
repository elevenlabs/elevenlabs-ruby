# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationTtsUsageModelTest < Minitest::Test
  def test_round_trip
    wire = { 'primary_tts_model' => 'test-value', 'total_audio_output_seconds' => 1, 'total_characters' => 1, 'per_voice_usage' => [{ 'voice_id' => 'test-value', 'audio_output_seconds' => 1 }] }

    instance = ::Elevenlabs::Types::ConversationTtsUsageModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
