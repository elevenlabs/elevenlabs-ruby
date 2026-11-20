# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetPhoneNumberTwilioResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'phone_number' => 'test-value', 'label' => 'test-value', 'supports_inbound' => true, 'supports_outbound' => true, 'phone_number_id' => 'test-value', 'assigned_agent' => { 'agent_id' => 'test-value', 'agent_name' => 'test-value', 'environment' => 'test-value', 'branch_id' => 'test-value' }, 'provider' => 'twilio' }

    instance = ::Elevenlabs::Types::GetPhoneNumberTwilioResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
