# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkflowUpdateStateNodeModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'update_state', 'position' => { 'x' => 1, 'y' => 1 }, 'edge_order' => ['test-value'], 'label' => 'test-value', 'updates' => [{ 'type' => 'dynamic_variable', 'variable_name' => 'test-value', 'expression' => { 'type' => 'string_literal', 'value' => 'test-value' }, 'required' => true }] }

    instance = ::Elevenlabs::Types::WorkflowUpdateStateNodeModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
