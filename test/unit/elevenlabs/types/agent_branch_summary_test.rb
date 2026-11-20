# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentBranchSummaryTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'name' => 'test-value', 'agent_id' => 'test-value', 'description' => 'test-value', 'created_at' => 1, 'last_committed_at' => 1, 'is_archived' => true, 'protection_status' => 'writer_perms_required', 'auto_rebase' => true, 'sync_status' => { 'last_attempt' => { 'outcome' => 'succeeded', 'attempted_at' => 1 } }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'current_live_percentage' => 1, 'parent_branch_id' => 'test-value', 'draft_exists' => true, 'draft_created_at' => 1, 'draft_is_behind_tip' => true, 'calls_7d' => 1, 'commits_ahead' => 1, 'commits_behind' => 1, 'merged_into_branch_id' => 'test-value' }

    instance = ::Elevenlabs::Types::AgentBranchSummary.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
