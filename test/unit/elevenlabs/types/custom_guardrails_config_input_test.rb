# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CustomGuardrailsConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'configs' => [{ 'is_enabled' => true, 'name' => 'test-value', 'prompt' => 'test-value', 'execution_mode' => 'streaming', 'model' => 'gemini-2.5-flash-lite', 'service_tier' => 'standard', 'history_message_count' => 0, 'trigger_action' => { 'type' => 'end_call' }, 'evaluate_full_response_only' => true }] }

    instance = ::Elevenlabs::Types::CustomGuardrailsConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
