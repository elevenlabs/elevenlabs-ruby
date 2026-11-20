# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationTurnMetricsTest < Minitest::Test
  def test_round_trip
    wire = { 'metrics' => { 'key' => { 'elapsed_time' => 1 } }, 'convai_asr_provider' => 'test-value', 'convai_tts_model' => 'test-value', 'convai_tts_cascade' => 'test-value', 'voice_id' => 'test-value' }

    instance = ::Elevenlabs::Types::ConversationTurnMetrics.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
