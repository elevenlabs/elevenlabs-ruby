# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryTranscriptWorkflowToolsResultCommonModelInputTest < Minitest::Test
  def test_round_trip
    wire = { 'request_id' => 'test-value', 'tool_name' => 'test-value', 'tool_id' => 'test-value', 'result_value' => 'test-value', 'is_error' => true, 'is_blocked' => true, 'tool_has_been_called' => true, 'tool_latency_secs' => 1, 'error_type' => 'test-value', 'raw_error_message' => 'test-value', 'dynamic_variable_updates' => [{ 'variable_name' => 'test-value', 'old_value' => 'test-value', 'new_value' => 'test-value', 'updated_at' => 1, 'tool_name' => 'test-value', 'tool_request_id' => 'test-value' }], 'type' => 'workflow', 'result' => { 'steps' => [{ 'step_latency_secs' => 1, 'type' => 'edge', 'edge_id' => 'test-value', 'target_node_id' => 'test-value' }] } }

    instance = ::Elevenlabs::Types::ConversationHistoryTranscriptWorkflowToolsResultCommonModelInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
