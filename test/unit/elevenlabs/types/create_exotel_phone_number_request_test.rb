# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateExotelPhoneNumberRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number' => 'test-value', 'label' => 'test-value', 'supports_inbound' => true, 'supports_outbound' => true, 'provider' => 'exotel', 'agent_id' => 'test-value', 'account_sid' => 'test-value', 'api_key' => 'test-value', 'api_token' => 'test-value', 'api_subdomain' => 'api.in.exotel.com', 'app_id' => 'test-value', 'applet_url' => 'test-value' }

    instance = ::Elevenlabs::Types::CreateExotelPhoneNumberRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
