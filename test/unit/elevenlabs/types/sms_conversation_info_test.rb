# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SmsConversationInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'direction' => 'inbound', 'phone_number_id' => 'test-value', 'sms_user_phone_number' => 'test-value', 'agent_phone_number' => 'test-value' }

    instance = ::Elevenlabs::Types::SmsConversationInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
