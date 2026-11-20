# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AstConditionalOperatorNodeInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'conditional_operator', 'condition' => { 'type' => 'string_literal', 'value' => 'test-value' }, 'trueExpression' => { 'type' => 'string_literal', 'value' => 'test-value' }, 'falseExpression' => { 'type' => 'string_literal', 'value' => 'test-value' } }

    instance = ::Elevenlabs::Types::AstConditionalOperatorNodeInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
