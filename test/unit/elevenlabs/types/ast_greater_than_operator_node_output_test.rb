# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AstGreaterThanOperatorNodeOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'gt_operator', 'left' => { 'type' => 'string_literal', 'value' => 'test-value' }, 'right' => { 'type' => 'string_literal', 'value' => 'test-value' } }

    instance = ::Elevenlabs::Types::AstGreaterThanOperatorNodeOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
