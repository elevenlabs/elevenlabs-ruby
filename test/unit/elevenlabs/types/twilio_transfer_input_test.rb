# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TwilioTransferInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'twilio', 'config' => { 'transfer_destination' => { 'destination' => 'test-value', 'type' => 'phone' }, 'post_dial_digits' => { 'type' => 'static', 'value' => 'test-value' }, 'type' => 'twilio_warm_conference_transfer' } }

    instance = ::Elevenlabs::Types::TwilioTransferInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
