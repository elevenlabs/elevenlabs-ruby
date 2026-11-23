# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentResponseCorrectionTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_response_correction_event' => { 'original_agent_response' => 'test-value', 'corrected_agent_response' => 'test-value', 'event_id' => 1, 'response_id' => 'test-value' }, 'type' => 'agent_response_correction' }

    instance = ::Elevenlabs::Types::AgentResponseCorrection.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
