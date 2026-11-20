# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateSipTrunkPhoneNumberRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number' => 'test-value', 'label' => 'test-value', 'supports_inbound' => true, 'supports_outbound' => true, 'provider' => 'sip_trunk', 'agent_id' => 'test-value', 'inbound_trunk_config' => { 'allowed_addresses' => ['test-value'], 'allowed_numbers' => ['test-value'], 'media_encryption' => 'disabled', 'credentials' => { 'username' => 'test-value', 'password' => 'test-value' }, 'remote_domains' => ['test-value'], 'attributes_to_headers' => { 'key' => 'test-value' } }, 'outbound_trunk_config' => { 'address' => 'test-value', 'transport' => 'auto', 'media_encryption' => 'disabled', 'headers' => { 'key' => 'test-value' }, 'attributes_to_headers' => { 'key' => 'test-value' }, 'credentials' => { 'username' => 'test-value', 'password' => 'test-value' }, 'enabled_codecs' => ['G722/8000'] } }

    instance = ::Elevenlabs::Types::CreateSipTrunkPhoneNumberRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
