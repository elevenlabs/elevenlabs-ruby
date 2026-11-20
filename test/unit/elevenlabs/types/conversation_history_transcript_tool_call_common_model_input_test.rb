# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryTranscriptToolCallCommonModelInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'system', 'request_id' => 'test-value', 'tool_name' => 'test-value', 'tool_id' => 'test-value', 'params_as_json' => 'test-value', 'tool_has_been_called' => true, 'tool_details' => { 'type' => 'webhook', 'method' => 'test-value', 'url' => 'test-value', 'headers' => { 'key' => 'test-value' }, 'path_params' => { 'key' => 'test-value' }, 'query_params' => { 'key' => 'test-value' }, 'body' => 'test-value' } }

    instance = ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallCommonModelInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
