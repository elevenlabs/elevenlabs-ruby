# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ListWhatsAppAccountsResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'items' => [{ 'business_account_id' => 'test-value', 'phone_number_id' => 'test-value', 'business_account_name' => 'test-value', 'phone_number_name' => 'test-value', 'phone_number' => 'test-value', 'account_type' => 'cloud_api', 'assigned_agent_id' => 'test-value', 'enable_messaging' => true, 'enable_audio_message_response' => true, 'enable_typing_indicator' => true, 'assigned_agent_name' => 'test-value', 'is_token_expired' => true }] }

    instance = ::Elevenlabs::Types::ListWhatsAppAccountsResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
