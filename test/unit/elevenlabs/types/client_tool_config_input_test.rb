# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ClientToolConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'client', 'name' => 'test-value', 'description' => 'test-value', 'response_timeout_secs' => -1, 'disable_interruptions' => true, 'interruption_mode' => 'allow', 'force_pre_tool_speech' => true, 'pre_tool_speech' => 'auto', 'assignments' => [{ 'source' => 'response', 'dynamic_variable' => 'test-value', 'value_path' => 'test-value', 'sanitize' => true, 'preserve_native_type' => true }], 'tool_call_sound' => 'typing', 'tool_call_sound_behavior' => 'auto', 'tool_error_handling_mode' => 'auto', 'parameters' => { 'property_kind' => 'array', 'description' => 'test-value', 'dynamic_variable' => 'test-value', 'constant_value' => {}, 'is_omitted' => true, 'type' => 'object', 'required' => ['test-value'], 'properties' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true } }, 'required_constraints' => { 'any_of' => [{ 'required' => ['test-value'] }], 'all_of' => [{ 'required' => ['test-value'] }] } }, 'expects_response' => true, 'dynamic_variables' => { 'dynamic_variable_placeholders' => {} }, 'execution_mode' => 'immediate' }

    instance = ::Elevenlabs::Types::ClientToolConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
