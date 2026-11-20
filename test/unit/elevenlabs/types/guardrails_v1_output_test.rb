# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GuardrailsV1OutputTest < Minitest::Test
  def test_round_trip
    wire = { 'version' => '1', 'focus' => { 'is_enabled' => true }, 'prompt_injection' => { 'is_enabled' => true }, 'content' => { 'execution_mode' => 'streaming', 'config' => { 'sexual' => { 'is_enabled' => true, 'threshold' => 1 }, 'violence' => { 'is_enabled' => true, 'threshold' => 1 }, 'harassment' => { 'is_enabled' => true, 'threshold' => 1 }, 'self_harm' => { 'is_enabled' => true, 'threshold' => 1 }, 'profanity' => { 'is_enabled' => true, 'threshold' => 1 }, 'religion_or_politics' => { 'is_enabled' => true, 'threshold' => 1 }, 'medical_and_legal_information' => { 'is_enabled' => true, 'threshold' => 1 } }, 'trigger_action' => { 'type' => 'end_call' } }, 'custom' => { 'config' => { 'configs' => [{ 'is_enabled' => true, 'name' => 'test-value', 'prompt' => 'test-value', 'execution_mode' => 'streaming', 'model' => 'gemini-2.5-flash-lite', 'service_tier' => 'standard', 'history_message_count' => 0, 'trigger_action' => { 'type' => 'end_call' }, 'evaluate_full_response_only' => true }] } } }

    instance = ::Elevenlabs::Types::GuardrailsV1Output.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
