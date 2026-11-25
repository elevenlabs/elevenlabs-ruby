# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentToolResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_tool_response' => { 'tool_name' => 'test-value', 'tool_call_id' => 'test-value', 'tool_type' => 'test-value', 'is_error' => true, 'is_blocked' => true, 'event_id' => 1, 'is_called' => true, 'status' => 'success' }, 'type' => 'agent_tool_response' }

    instance = ::Elevenlabs::Types::AgentToolResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
