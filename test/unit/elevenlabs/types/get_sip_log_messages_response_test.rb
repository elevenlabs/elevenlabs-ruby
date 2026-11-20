# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetSipLogMessagesResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'sip_messages' => [{ 'call_id' => 'test-value', 'phone_numbers' => ['test-value'], 'local_address' => 'test-value', 'remote_address' => 'test-value', 'transport' => 'test-value', 'raw_message' => 'test-value', 'error_message' => 'test-value', 'direction' => 'in', 'created_at_unix_micro' => 1 }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetSipLogMessagesResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
