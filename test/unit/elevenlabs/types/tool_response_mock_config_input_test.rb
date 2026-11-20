# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ToolResponseMockConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'parameter_conditions' => [{ 'eval' => { 'type' => 'llm', 'description' => 'test-value' }, 'path' => 'test-value' }], 'mock_result' => 'test-value', 'is_error' => true }

    instance = ::Elevenlabs::Types::ToolResponseMockConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
