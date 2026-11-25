# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentToolRequestAgentToolRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'tool_name' => 'test-value', 'tool_call_id' => 'test-value', 'tool_type' => 'test-value', 'event_id' => 1, 'expects_response' => true, 'disable_interruptions' => true, 'response_timeout_secs' => 1, 'execution_mode' => 'test-value' }

    instance = ::Elevenlabs::Types::AgentToolRequestAgentToolRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
