# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkflowEdgeModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'source' => 'test-value', 'target' => 'test-value', 'forward_condition' => { 'label' => 'test-value', 'type' => 'unconditional' }, 'backward_condition' => { 'label' => 'test-value', 'type' => 'unconditional' }, 'reroutes' => [{ 'x' => 1, 'y' => 1 }] }

    instance = ::Elevenlabs::Types::WorkflowEdgeModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
