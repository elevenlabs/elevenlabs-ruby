# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpConnectionStatusMcpConnectionStatusIntegrationsItemTest < Minitest::Test
  def test_round_trip
    wire = { 'integration_id' => 'test-value', 'integration_type' => 'mcp_server', 'is_connected' => true, 'tool_count' => 1 }

    instance = ::Elevenlabs::Types::McpConnectionStatusMcpConnectionStatusIntegrationsItem.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
