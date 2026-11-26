# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolAddApprovalRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'tool_name' => 'test-value', 'tool_description' => 'test-value', 'input_schema' => {}, 'approval_policy' => 'auto_approved' }

    instance = ::Elevenlabs::Agents::McpServers::ToolApprovals::Types::McpToolAddApprovalRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('mcp_server_id'))
  end
end
