# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryBatchCallModelTest < Minitest::Test
  def test_round_trip
    wire = { 'batch_call_id' => 'test-value', 'batch_call_recipient_id' => 'test-value', 'campaign' => { 'campaign_id' => 'test-value', 'campaign_lead_id' => 'test-value', 'cold_attempt' => 1, 'conversation_type' => 'initial' } }

    instance = ::Elevenlabs::Types::ConversationHistoryBatchCallModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
