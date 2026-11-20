# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TestToolResultModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'testing_tool_result', 'status' => 'success', 'reason' => 'test-value', 'to_agent' => 'test-value', 'to_node' => 'test-value' }

    instance = ::Elevenlabs::Types::TestToolResultModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
