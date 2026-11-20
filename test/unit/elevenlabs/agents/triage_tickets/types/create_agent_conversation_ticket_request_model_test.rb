# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateAgentConversationTicketRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_id' => 'test-value', 'title' => 'test-value', 'qa_comment' => 'test-value', 'turn_comments' => [{ 'turn_index' => 0, 'comment' => 'test-value' }], 'priority' => 'low' }

    instance = ::Elevenlabs::Agents::TriageTickets::Types::CreateAgentConversationTicketRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
