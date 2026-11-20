# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DataCollectionValueSchemaTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true }

    instance = ::Elevenlabs::Types::DataCollectionValueSchema.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
