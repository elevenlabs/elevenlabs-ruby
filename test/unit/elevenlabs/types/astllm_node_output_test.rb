# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AstllmNodeOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'llm', 'value_schema' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'] }, 'prompt' => 'test-value' }

    instance = ::Elevenlabs::Types::AstllmNodeOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
