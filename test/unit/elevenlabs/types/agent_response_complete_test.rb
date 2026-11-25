# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentResponseCompleteTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_response_complete_event' => { 'event_id' => 1 }, 'type' => 'agent_response_complete' }

    instance = ::Elevenlabs::Types::AgentResponseComplete.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
