# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetAgentConversationTicketsPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'agent_conversation_tickets' => [{ 'agentqa_ticket_id' => 'test-value', 'workspace_id' => 'test-value', 'owner_user_id' => 'test-value', 'agent_id' => 'test-value', 'needs_clustering' => true, 'title' => 'test-value', 'issue_type' => {}, 'labels' => ['test-value'], 'conversation_ids' => ['test-value'], 'first_seen_unix_secs' => 1, 'last_seen_unix_secs' => 1, 'qa_comment' => 'test-value', 'ticket_comments' => [{ 'comment' => 'test-value', 'created_at_unix_secs' => 1, 'owner_user_id' => 'test-value' }], 'turn_comments' => [{ 'turn_index' => 1, 'comment' => 'test-value', 'created_at_unix_secs' => 1, 'owner_user_id' => 'test-value' }], 'status' => 'open', 'priority' => 'low', 'priority_changes' => [{ 'priority' => 'low', 'changed_by_user_id' => 'test-value', 'changed_at_unix_secs' => 1 }], 'status_changes' => [{ 'status' => 'open', 'changed_by_user_id' => 'test-value', 'changed_at_unix_secs' => 1 }], 'merged_into_ticket_id' => 'test-value', 'source' => 'qa', 'assignee_user_id' => 'test-value', 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'search_match' => { 'field' => 'title', 'snippet' => 'test-value', 'highlight_start' => 1, 'highlight_end' => 1, 'turn_index' => 1 } }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetAgentConversationTicketsPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
