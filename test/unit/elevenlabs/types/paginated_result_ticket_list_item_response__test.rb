# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PaginatedResultTicketListItemResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'results' => [{ 'id' => 'test-value', 'subject' => 'test-value', 'status' => 'open', 'priority' => 'low', 'requester' => { 'id' => 'test-value', 'first_name' => 'test-value', 'last_name' => 'test-value', 'full_name' => 'test-value', 'email' => 'test-value' }, 'assignee' => { 'type' => 'ai_agent', 'id' => 'test-value', 'name' => 'test-value' }, 'secondary_assignee' => { 'type' => 'ai_agent', 'id' => 'test-value', 'name' => 'test-value' }, 'subscribers' => [{ 'type' => 'human_agent', 'id' => 'test-value', 'name' => 'test-value', 'email' => 'test-value' }], 'tag_ids' => ['test-value'], 'sla' => { 'metric' => 'first_response', 'duration_secs' => 1, 'started_at_unix_secs' => 1, 'due_at_unix_secs' => 1 }, 'deadline_at_unix_secs' => 1, 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1 }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::PaginatedResultTicketListItemResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
