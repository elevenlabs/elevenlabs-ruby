# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkflowExpressionConditionModelOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'label' => 'test-value', 'type' => 'expression', 'expression' => { 'type' => 'string_literal', 'value' => 'test-value' } }

    instance = ::Elevenlabs::Types::WorkflowExpressionConditionModelOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
