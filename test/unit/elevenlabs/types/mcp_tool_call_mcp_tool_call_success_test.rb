# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolCallMcpToolCallSuccessTest < Minitest::Test
  def test_round_trip
    wire = { 'service_id' => 'test-value', 'tool_call_id' => 'test-value', 'tool_name' => 'test-value', 'tool_description' => 'test-value', 'parameters' => {}, 'timestamp' => 'test-value', 'state' => 'success', 'result' => [{}] }

    instance = ::Elevenlabs::Types::McpToolCallMcpToolCallSuccess.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
