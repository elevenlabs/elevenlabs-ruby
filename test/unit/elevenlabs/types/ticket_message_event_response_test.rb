# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TicketMessageEventResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'visibility' => 'public', 'author' => { 'id' => 'test-value', 'first_name' => 'test-value', 'last_name' => 'test-value', 'full_name' => 'test-value', 'email' => 'test-value', 'type' => 'requester' }, 'created_at_unix_secs' => 1, 'type' => 'message', 'body' => 'test-value' }

    instance = ::Elevenlabs::Types::TicketMessageEventResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
