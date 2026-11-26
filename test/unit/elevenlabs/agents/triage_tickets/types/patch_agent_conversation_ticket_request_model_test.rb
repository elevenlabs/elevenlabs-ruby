# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PatchAgentConversationTicketRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'title' => 'test-value', 'qa_comment' => 'test-value', 'status' => 'open', 'assignee_user_id' => 'test-value', 'priority' => 'low' }

    instance = ::Elevenlabs::Agents::TriageTickets::Types::PatchAgentConversationTicketRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('agentqa_ticket_id'))
  end
end
