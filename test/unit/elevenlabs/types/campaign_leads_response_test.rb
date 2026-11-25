# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CampaignLeadsResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'leads' => [{ 'lead_id' => 'test-value', 'recipient_id' => 'test-value', 'phone_number' => 'test-value', 'phone_numbers' => ['test-value'], 'phone_numbers_index' => 1, 'timezone_override' => 'test-value', 'user_id' => 'test-value', 'attempt_count' => 1, 'failure_count' => 1, 'callback_count' => 1, 'redirect_count' => 1, 'do_not_call' => true, 'terminal_disposition' => 'campaign_ended', 'created_at_unix' => 1, 'updated_at_unix' => 1, 'dynamic_variables' => {}, 'overrides' => { 'language' => 'test-value', 'first_message' => 'test-value', 'prompt' => 'test-value', 'voice_id' => 'test-value' }, 'delivery' => { 'status' => 'pending', 'stage' => 'queued', 'sent_at_unix' => 1, 'delivered_at_unix' => 1, 'read_at_unix' => 1, 'replied_at_unix' => 1, 'failed_at_unix' => 1, 'error_message' => 'test-value' } }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::CampaignLeadsResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
