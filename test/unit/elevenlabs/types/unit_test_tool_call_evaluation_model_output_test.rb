# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UnitTestToolCallEvaluationModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'parameters' => [{ 'eval' => { 'type' => 'llm', 'description' => 'test-value' }, 'path' => 'test-value' }], 'referenced_tool' => { 'id' => 'test-value', 'type' => 'system' }, 'verify_absence' => true, 'workflow_node_transition' => { 'type' => 'node_id', 'agent_id' => 'test-value', 'target_node_id' => 'test-value' }, 'guardrail_trigger' => { 'type' => 'any' } }

    instance = ::Elevenlabs::Types::UnitTestToolCallEvaluationModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
