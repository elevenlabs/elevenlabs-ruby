# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InterruptionTest < Minitest::Test
  def test_round_trip
    wire = { 'interruption_event' => { 'event_id' => 1 }, 'type' => 'interruption' }

    instance = ::Elevenlabs::Types::Interruption.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
