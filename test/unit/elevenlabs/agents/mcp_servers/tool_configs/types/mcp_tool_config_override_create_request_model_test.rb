# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolConfigOverrideCreateRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'force_pre_tool_speech' => true, 'pre_tool_speech' => 'auto', 'disable_interruptions' => true, 'interruption_mode' => 'allow', 'tool_call_sound' => 'typing', 'tool_call_sound_behavior' => 'auto', 'execution_mode' => 'immediate', 'response_timeout_secs' => 5, 'assignments' => [{ 'source' => 'response', 'dynamic_variable' => 'test-value', 'value_path' => 'test-value', 'sanitize' => true, 'preserve_native_type' => true }], 'input_overrides' => { 'key' => { 'source' => 'constant', 'constant_value' => 'test-value' } }, 'response_mocks' => [{ 'parameter_conditions' => [{ 'eval' => { 'type' => 'llm', 'description' => 'test-value' }, 'path' => 'test-value' }], 'mock_result' => 'test-value', 'is_error' => true }], 'tool_name' => 'test-value' }

    instance = ::Elevenlabs::Agents::McpServers::ToolConfigs::Types::McpToolConfigOverrideCreateRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('mcp_server_id', 'environment'))
  end
end
