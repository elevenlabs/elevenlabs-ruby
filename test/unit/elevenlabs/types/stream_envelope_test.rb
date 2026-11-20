# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class StreamEnvelopeTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_id' => 'test-value', 'turn_id' => 'test-value', 'created_at_unix_ms' => 1, 'event' => { 'type' => 'stream_ended', 'stream_ended_event' => { 'status' => 'in_progress', 'error' => { 'type' => 'test-value', 'code' => 'test-value', 'message' => 'test-value' }, 'required_actions' => [{ 'type' => 'client_tool_call', 'tool_call_id' => 'test-value', 'tool_name' => 'test-value', 'parameters' => {} }] } } }

    instance = ::Elevenlabs::Types::StreamEnvelope.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
