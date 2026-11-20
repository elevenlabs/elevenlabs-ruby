# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetPhoneNumberOutboundSipTrunkConfigResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'address' => 'test-value', 'transport' => 'auto', 'media_encryption' => 'disabled', 'headers' => { 'key' => 'test-value' }, 'attributes_to_headers' => { 'key' => 'test-value' }, 'has_auth_credentials' => true, 'username' => 'test-value', 'has_outbound_trunk' => true, 'enabled_codecs' => ['G722/8000'] }

    instance = ::Elevenlabs::Types::GetPhoneNumberOutboundSipTrunkConfigResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
