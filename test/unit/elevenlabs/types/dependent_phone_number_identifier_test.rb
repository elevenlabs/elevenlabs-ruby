# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DependentPhoneNumberIdentifierTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number_id' => 'test-value', 'phone_number' => 'test-value', 'label' => 'test-value', 'provider' => 'twilio' }

    instance = ::Elevenlabs::Types::DependentPhoneNumberIdentifier.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
