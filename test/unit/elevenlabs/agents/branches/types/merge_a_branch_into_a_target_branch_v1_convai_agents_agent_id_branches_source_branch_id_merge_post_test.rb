# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyMergeABranchIntoATargetBranchV1ConvaiAgentsAgentIDBranchesSourceBranchIDMergePostTest < Minitest::Test
  def test_round_trip
    wire = { 'archive_source_branch' => true, 'force' => true, 'conflict_resolutions' => [{ 'conflict_id' => 'test-value', 'choice' => 'source', 'custom_value' => 'test-value' }], 'source_tip_id' => 'test-value', 'target_tip_id' => 'test-value' }

    instance = ::Elevenlabs::Agents::Branches::Types::BodyMergeABranchIntoATargetBranchV1ConvaiAgentsAgentIDBranchesSourceBranchIDMergePost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id', 'source_branch_id', 'target_branch_id'))
  end
end
