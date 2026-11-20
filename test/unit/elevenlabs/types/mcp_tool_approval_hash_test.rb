# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class McpToolApprovalHashTest < Minitest::Test
  def test_round_trip
    wire = { 'tool_name' => 'test-value', 'tool_hash' => 'test-value', 'approval_policy' => 'auto_approved' }

    instance = ::Elevenlabs::Types::McpToolApprovalHash.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
