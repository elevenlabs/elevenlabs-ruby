# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationAgentResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_response_event' => { 'agent_response' => 'test-value', 'event_id' => 1, 'response_id' => 'test-value', 'in_response_to_ids' => ['test-value'], 'response_type' => 'text', 'attachments' => [{ 'url' => 'test-value', 'name' => 'test-value', 'mime_type' => 'test-value' }] }, 'type' => 'agent_response' }

    instance = ::Elevenlabs::Types::ConversationAgentResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
