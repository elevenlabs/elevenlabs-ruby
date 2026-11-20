# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OpenAiAudioConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'input' => { 'format' => { 'type' => 'audio/pcm', 'rate' => 1 }, 'transcription' => { 'language' => 'test-value' }, 'turn_detection' => { 'type' => 'semantic_vad', 'eagerness' => 'low', 'create_response' => true, 'interrupt_response' => true, 'threshold' => 1, 'prefix_padding_ms' => 1, 'silence_duration_ms' => 1, 'turn_timeout' => 1 }, 'pacing' => 'realtime' }, 'output' => { 'format' => { 'type' => 'audio/pcm' }, 'voice' => 'test-value' } }

    instance = ::Elevenlabs::Types::OpenAiAudioConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
