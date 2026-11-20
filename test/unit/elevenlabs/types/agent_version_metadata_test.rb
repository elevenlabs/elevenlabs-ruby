# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentVersionMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'version_description' => 'test-value', 'seq_no_in_branch' => 1, 'time_committed_secs' => 1, 'parents' => { 'in_branch_parent_id' => 'test-value', 'out_of_branch_parent_id' => 'test-value', 'merged_into_branch_id' => 'test-value', 'merged_from_branch_id' => 'test-value', 'merged_from_version_id' => 'test-value', 'rebased_from_version_id' => 'test-value' }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'merged_authors' => [{ 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }] }

    instance = ::Elevenlabs::Types::AgentVersionMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
