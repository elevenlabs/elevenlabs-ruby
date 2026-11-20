# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolApprovalStatusTest < Minitest::Test
  def test_round_trip
    wire = { 'tool_id' => 'test-value', 'state' => 'up_to_date', 'approval_policy' => 'auto_approved', 'approved_definition' => { 'description' => 'test-value', 'input_schema' => {} } }

    instance = ::Elevenlabs::Types::McpToolApprovalStatus.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
