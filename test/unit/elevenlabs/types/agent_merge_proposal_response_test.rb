# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentMergeProposalResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'agent_id' => 'test-value', 'source_branch_id' => 'test-value', 'target_branch_id' => 'test-value', 'source_tip_version_id_at_creation' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'requested_reviewer_user_ids' => ['test-value'], 'reviews' => [{ 'user_id' => 'test-value', 'state' => 'approved', 'submitted_at' => 1, 'comment' => 'test-value', 'reviewer_role' => 'admin' }], 'comments' => [{ 'id' => 'test-value', 'user_id' => 'test-value', 'body' => 'test-value', 'created_at' => 1 }], 'outcome' => { 'status' => 'open' }, 'created_at' => 1, 'updated_at' => 1, 'author_user_id' => 'test-value', 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' } }

    instance = ::Elevenlabs::Types::AgentMergeProposalResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
