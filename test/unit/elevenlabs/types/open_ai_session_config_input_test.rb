# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OpenAiSessionConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'realtime', 'model' => 'eleven_realtime_v1_mini', 'instructions' => 'test-value', 'output_modalities' => ['test-value'], 'audio' => { 'input' => { 'format' => { 'type' => 'audio/pcm', 'rate' => 1 }, 'transcription' => { 'language' => 'test-value' }, 'turn_detection' => { 'type' => 'semantic_vad', 'eagerness' => 'low', 'create_response' => true, 'interrupt_response' => true, 'threshold' => 1, 'prefix_padding_ms' => 1, 'silence_duration_ms' => 1, 'turn_timeout' => 1 }, 'pacing' => 'realtime' }, 'output' => { 'format' => { 'type' => 'audio/pcm' }, 'voice' => 'test-value' } }, 'tools' => [{ 'type' => 'function', 'name' => 'test-value', 'description' => 'test-value', 'parameters' => {} }], 'tool_choice' => 'test-value', 'temperature' => 1, 'max_response_output_tokens' => 1, 'max_duration_seconds' => 60, 'turn_detection' => { 'type' => 'semantic_vad', 'eagerness' => 'low', 'create_response' => true, 'interrupt_response' => true, 'threshold' => 1, 'prefix_padding_ms' => 1, 'silence_duration_ms' => 1, 'turn_timeout' => 1 }, 'tracing' => 'auto', 'include' => ['test-value'], 'parallel_tool_calls' => true, 'reasoning' => {}, 'truncation' => 'test-value', 'prompt' => {} }

    instance = ::Elevenlabs::Types::OpenAiSessionConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
