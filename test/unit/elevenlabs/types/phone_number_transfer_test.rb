# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PhoneNumberTransferTest < Minitest::Test
  def test_round_trip
    wire = { 'custom_sip_headers' => [{ 'type' => 'static', 'key' => 'test-value', 'value' => 'test-value' }], 'transfer_destination' => { 'type' => 'phone', 'phone_number' => 'test-value' }, 'transfer_type' => 'blind', 'sip_refer_play_dialtone' => true, 'uui' => { 'data' => 'test-value', 'protocol_discriminator' => 'test-value', 'protocol_discriminator_mode' => 'prefix' }, 'post_dial_digits' => { 'type' => 'static', 'value' => 'test-value' }, 'phone_number' => 'test-value', 'condition' => 'test-value' }

    instance = ::Elevenlabs::Types::PhoneNumberTransfer.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
