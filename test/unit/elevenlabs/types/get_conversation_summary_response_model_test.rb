# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetConversationSummaryResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_id' => 'test-value', 'agent_id' => 'test-value', 'status' => 'initiated', 'call_summary_title' => 'test-value', 'transcript_summary' => 'test-value', 'call_successful' => 'success', 'message_count' => 1, 'messages' => [{ 'role' => 'user', 'message' => 'test-value' }], 'messages_omitted' => true, 'note' => 'test-value' }

    instance = ::Elevenlabs::Types::GetConversationSummaryResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
