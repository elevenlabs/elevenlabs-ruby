# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateTwilioPhoneNumberRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number' => 'test-value', 'label' => 'test-value', 'supports_inbound' => true, 'supports_outbound' => true, 'provider' => 'twilio', 'agent_id' => 'test-value', 'sid' => 'test-value', 'token' => 'test-value', 'account_auth_token' => 'test-value', 'region_config' => { 'region_id' => 'us1', 'token' => 'test-value', 'edge_location' => 'ashburn' }, 'enable_sms' => true }

    instance = ::Elevenlabs::Types::CreateTwilioPhoneNumberRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
