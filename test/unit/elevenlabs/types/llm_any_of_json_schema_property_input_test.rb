# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class LlmAnyOfJSONSchemaPropertyInputTest < Minitest::Test
  def test_round_trip
    wire = { 'any_of' => [{ 'type' => 'object', 'required' => ['test-value'], 'description' => 'test-value', 'properties' => { 'key' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'] } } }], 'description' => 'test-value' }

    instance = ::Elevenlabs::Types::LlmAnyOfJSONSchemaPropertyInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
