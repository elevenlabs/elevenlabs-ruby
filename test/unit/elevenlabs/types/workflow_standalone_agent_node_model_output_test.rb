# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkflowStandaloneAgentNodeModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'standalone_agent', 'position' => { 'x' => 1, 'y' => 1 }, 'edge_order' => ['test-value'], 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'node_id' => 'test-value', 'delay_ms' => 1, 'transfer_message' => 'test-value', 'enable_transferred_agent_first_message' => true, 'preserve_client_tts_overrides' => true, 'preserve_voice_settings' => true }

    instance = ::Elevenlabs::Types::WorkflowStandaloneAgentNodeModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
