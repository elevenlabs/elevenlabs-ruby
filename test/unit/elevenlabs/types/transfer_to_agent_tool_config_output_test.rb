# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TransferToAgentToolConfigOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'system_tool_type' => 'transfer_to_agent', 'transfers' => [{ 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'node_id' => 'test-value', 'condition' => 'test-value', 'delay_ms' => 1, 'transfer_message' => 'test-value', 'enable_transferred_agent_first_message' => true, 'is_workflow_node_transfer' => true, 'preserve_client_tts_overrides' => true, 'preserve_voice_settings' => true }] }

    instance = ::Elevenlabs::Types::TransferToAgentToolConfigOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
