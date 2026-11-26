# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ClientToolCallTest < Minitest::Test
  def test_round_trip
    wire = { 'client_tool_call' => { 'tool_name' => 'test-value', 'tool_call_id' => 'test-value', 'parameters' => {}, 'event_id' => 1, 'expects_response' => true }, 'type' => 'client_tool_call' }

    instance = ::Elevenlabs::Types::ClientToolCall.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
