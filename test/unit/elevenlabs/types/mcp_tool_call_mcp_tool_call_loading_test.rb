# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolCallMcpToolCallLoadingTest < Minitest::Test
  def test_round_trip
    wire = { 'service_id' => 'test-value', 'tool_call_id' => 'test-value', 'tool_name' => 'test-value', 'tool_description' => 'test-value', 'parameters' => {}, 'timestamp' => 'test-value', 'state' => 'loading' }

    instance = ::Elevenlabs::Types::McpToolCallMcpToolCallLoading.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
