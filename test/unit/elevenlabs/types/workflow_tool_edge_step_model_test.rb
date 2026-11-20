# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkflowToolEdgeStepModelTest < Minitest::Test
  def test_round_trip
    wire = { 'step_latency_secs' => 1, 'type' => 'edge', 'edge_id' => 'test-value', 'target_node_id' => 'test-value' }

    instance = ::Elevenlabs::Types::WorkflowToolEdgeStepModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
