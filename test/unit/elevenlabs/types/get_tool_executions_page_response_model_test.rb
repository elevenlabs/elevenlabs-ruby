# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetToolExecutionsPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'executions' => [{ 'tool_id' => 'test-value', 'tool_request_id' => 'test-value', 'conversation_id' => 'test-value', 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'timestamp' => 1, 'latency_secs' => 1, 'is_error' => true, 'request_payload' => 'test-value', 'response_payload' => 'test-value', 'error_message' => 'test-value', 'error_type' => 'test-value', 'id' => 'test-value', 'tool_call_details' => { 'type' => 'webhook', 'method' => 'test-value', 'url' => 'test-value', 'headers' => { 'key' => 'test-value' }, 'path_params' => { 'key' => 'test-value' }, 'query_params' => { 'key' => 'test-value' }, 'body' => 'test-value' } }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetToolExecutionsPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
