# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryTranscriptToolCallMcpDetailsTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'mcp', 'mcp_server_id' => 'test-value', 'mcp_server_name' => 'test-value', 'integration_type' => 'test-value', 'parameters' => { 'key' => 'test-value' }, 'approval_policy' => 'test-value', 'requires_approval' => true, 'mcp_tool_name' => 'test-value', 'mcp_tool_description' => 'test-value' }

    instance = ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallMcpDetails.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
