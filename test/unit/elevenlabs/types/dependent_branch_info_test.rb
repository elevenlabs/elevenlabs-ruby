# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DependentBranchInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_id' => 'test-value', 'agent_name' => 'test-value', 'branch_id' => 'test-value', 'branch_name' => 'test-value', 'is_main' => true }

    instance = ::Elevenlabs::Types::DependentBranchInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
