# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateTicketRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'requester' => { 'type' => 'user_id', 'value' => 'test-value' }, 'author' => { 'type' => 'requester' }, 'subject' => 'test-value', 'description' => 'test-value', 'priority' => 'low', 'deadline_at_unix_secs' => 1, 'tag_ids' => ['test-value'], 'assignee' => { 'type' => 'ai_agent', 'id' => 'test-value' }, 'secondary_assignee' => { 'type' => 'ai_agent', 'id' => 'test-value' }, 'subscribers' => [{ 'type' => 'human_agent', 'id' => 'test-value' }] }

    instance = ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
