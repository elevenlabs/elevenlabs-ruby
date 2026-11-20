# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SimulationToolMockBehaviorConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'mocking_strategy' => 'all', 'fallback_strategy' => 'call_real_tool', 'mocked_tool_ids' => ['test-value'] }

    instance = ::Elevenlabs::Types::SimulationToolMockBehaviorConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
