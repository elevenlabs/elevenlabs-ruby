# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionCreateTransferRuleRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'label' => 'test-value', 'phone_number' => 'test-value', 'condition' => 'test-value', 'post_dial_digits' => 'test-value' }

    instance = ::Elevenlabs::Reception::Receptionists::TransferRules::Types::ReceptionCreateTransferRuleRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
