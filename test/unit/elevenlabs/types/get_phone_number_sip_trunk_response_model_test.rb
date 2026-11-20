# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetPhoneNumberSipTrunkResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number' => 'test-value', 'label' => 'test-value', 'supports_inbound' => true, 'supports_outbound' => true, 'phone_number_id' => 'test-value', 'assigned_agent' => { 'agent_id' => 'test-value', 'agent_name' => 'test-value', 'environment' => 'test-value', 'branch_id' => 'test-value' }, 'provider' => 'sip_trunk', 'provider_config' => { 'address' => 'test-value', 'transport' => 'auto', 'media_encryption' => 'disabled', 'headers' => { 'key' => 'test-value' }, 'attributes_to_headers' => { 'key' => 'test-value' }, 'has_auth_credentials' => true, 'username' => 'test-value', 'has_outbound_trunk' => true, 'enabled_codecs' => ['G722/8000'] }, 'outbound_trunk' => { 'address' => 'test-value', 'transport' => 'auto', 'media_encryption' => 'disabled', 'headers' => { 'key' => 'test-value' }, 'attributes_to_headers' => { 'key' => 'test-value' }, 'has_auth_credentials' => true, 'username' => 'test-value', 'has_outbound_trunk' => true, 'enabled_codecs' => ['G722/8000'] }, 'inbound_trunk' => { 'allowed_addresses' => ['test-value'], 'allowed_numbers' => ['test-value'], 'media_encryption' => 'disabled', 'has_auth_credentials' => true, 'username' => 'test-value', 'remote_domains' => ['test-value'], 'attributes_to_headers' => { 'key' => 'test-value' } }, 'livekit_stack' => 'standard', 'store_sip_messages' => true }

    instance = ::Elevenlabs::Types::GetPhoneNumberSipTrunkResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
