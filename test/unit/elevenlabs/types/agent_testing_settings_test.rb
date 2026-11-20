# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentTestingSettingsTest < Minitest::Test
  def test_round_trip
    wire = { 'attached_tests' => [{ 'test_id' => 'test-value', 'workflow_node_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::AgentTestingSettings.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
