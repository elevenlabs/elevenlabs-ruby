# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SubAgentOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'execution_mode' => 'immediate', 'timeout_secs' => 10, 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'description' => 'test-value', 'parameters' => { 'description' => 'test-value', 'dynamic_variable' => 'test-value', 'constant_value' => {}, 'is_omitted' => true, 'type' => 'object', 'required' => ['test-value'], 'properties' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true } }, 'required_constraints' => { 'any_of' => [{ 'required' => ['test-value'] }], 'all_of' => [{ 'required' => ['test-value'] }] } } }

    instance = ::Elevenlabs::Types::SubAgentOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
