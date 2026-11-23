# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpConnectionStatusTest < Minitest::Test
  def test_round_trip
    wire = { 'mcp_connection_status' => { 'integrations' => [{ 'integration_id' => 'test-value', 'integration_type' => 'mcp_server', 'is_connected' => true, 'tool_count' => 1 }] }, 'type' => 'mcp_connection_status' }

    instance = ::Elevenlabs::Types::McpConnectionStatus.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
