# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolCallTest < Minitest::Test
  def test_round_trip
    wire = { 'mcp_tool_call' => { 'service_id' => 'test-value', 'tool_call_id' => 'test-value', 'tool_name' => 'test-value', 'tool_description' => 'test-value', 'parameters' => {}, 'timestamp' => 'test-value', 'state' => 'loading' }, 'type' => 'mcp_tool_call' }

    instance = ::Elevenlabs::Types::McpToolCall.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
