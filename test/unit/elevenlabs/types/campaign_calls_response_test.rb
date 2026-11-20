# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CampaignCallsResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'calls' => [{ 'intent_id' => 'test-value', 'lead_id' => 'test-value', 'intent_type' => 'initial', 'cold_attempt' => 1, 'status' => 'queued', 'phone_number' => 'test-value', 'scheduled_time_unix' => 1, 'conversation_id' => 'test-value', 'outcome' => 'pending', 'call_result' => 'answered', 'outcome_at_unix' => 1, 'decision_disposition' => 'completed', 'collected_dynamic_variables' => {}, 'delivery' => { 'status' => 'pending', 'stage' => 'queued', 'sent_at_unix' => 1, 'delivered_at_unix' => 1, 'read_at_unix' => 1, 'replied_at_unix' => 1, 'failed_at_unix' => 1, 'error_message' => 'test-value' } }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::CampaignCallsResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
