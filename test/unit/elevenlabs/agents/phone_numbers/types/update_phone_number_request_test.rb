# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdatePhoneNumberRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_id' => 'test-value', 'label' => 'test-value', 'inbound_trunk_config' => { 'allowed_addresses' => ['test-value'], 'allowed_numbers' => ['test-value'], 'media_encryption' => 'disabled', 'credentials' => { 'username' => 'test-value', 'password' => 'test-value' }, 'remote_domains' => ['test-value'], 'attributes_to_headers' => { 'key' => 'test-value' } }, 'outbound_trunk_config' => { 'address' => 'test-value', 'transport' => 'auto', 'media_encryption' => 'disabled', 'headers' => { 'key' => 'test-value' }, 'attributes_to_headers' => { 'key' => 'test-value' }, 'credentials' => { 'username' => 'test-value', 'password' => 'test-value' }, 'enabled_codecs' => ['G722/8000'] }, 'livekit_stack' => 'standard', 'store_sip_messages' => true, 'environment' => 'test-value', 'branch_id' => 'test-value' }

    instance = ::Elevenlabs::Agents::PhoneNumbers::Types::UpdatePhoneNumberRequest.new(wire)

    assert_equal(wire, instance.to_h.except('phone_number_id'))
  end
end
