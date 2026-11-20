# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentVersionParentsTest < Minitest::Test
  def test_round_trip
    wire = { 'in_branch_parent_id' => 'test-value', 'out_of_branch_parent_id' => 'test-value', 'merged_into_branch_id' => 'test-value', 'merged_from_branch_id' => 'test-value', 'merged_from_version_id' => 'test-value', 'rebased_from_version_id' => 'test-value' }

    instance = ::Elevenlabs::Types::AgentVersionParents.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
