# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationPingTest < Minitest::Test
  def test_round_trip
    wire = { 'ping_event' => { 'event_id' => 1, 'ping_ms' => 1 }, 'type' => 'ping' }

    instance = ::Elevenlabs::Types::ConversationPing.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
