# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkflowFeaturesUsageCommonModelTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'tool_node' => { 'enabled' => true, 'used' => true }, 'standalone_agent_node' => { 'enabled' => true, 'used' => true }, 'phone_number_node' => { 'enabled' => true, 'used' => true }, 'end_node' => { 'enabled' => true, 'used' => true }, 'override_agent_node' => { 'enabled' => true, 'used' => true } }

    instance = ::Elevenlabs::Types::WorkflowFeaturesUsageCommonModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
