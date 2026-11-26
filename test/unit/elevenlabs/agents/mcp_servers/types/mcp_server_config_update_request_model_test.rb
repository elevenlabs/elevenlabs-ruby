# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpServerConfigUpdateRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'approval_policy' => 'auto_approve_all', 'force_pre_tool_speech' => true, 'pre_tool_speech' => 'auto', 'disable_interruptions' => true, 'interruption_mode' => 'allow', 'tool_call_sound' => 'typing', 'tool_call_sound_behavior' => 'auto', 'execution_mode' => 'immediate', 'response_timeout_secs' => 5, 'request_headers' => { 'key' => 'test-value' }, 'request_meta' => { 'key' => 'test-value' }, 'disable_compression' => true, 'secret_token' => { 'secret_id' => 'test-value' }, 'auth_connection' => { 'auth_connection_id' => 'test-value' } }

    instance = ::Elevenlabs::Agents::McpServers::Types::McpServerConfigUpdateRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('mcp_server_id'))
  end
end
