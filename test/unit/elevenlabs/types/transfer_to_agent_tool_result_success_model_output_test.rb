# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TransferToAgentToolResultSuccessModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'transfer_to_agent_success', 'status' => 'success', 'from_agent' => 'test-value', 'to_agent' => 'test-value', 'to_node' => 'test-value', 'condition' => 'test-value', 'delay_ms' => 1, 'transfer_message' => 'test-value', 'enable_transferred_agent_first_message' => true, 'branch_info' => { 'branch_reason' => 'configured', 'branch_id' => 'test-value' }, 'preserve_client_tts_overrides' => true, 'preserve_voice_settings' => true }

    instance = ::Elevenlabs::Types::TransferToAgentToolResultSuccessModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
