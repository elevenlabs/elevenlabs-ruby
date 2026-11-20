# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetConversationUsersPageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'users' => [{ 'user_id' => 'test-value', 'last_contact_unix_secs' => 1, 'first_contact_unix_secs' => 1, 'conversation_count' => 1, 'last_contact_agent_id' => 'test-value', 'last_contact_conversation_id' => 'test-value', 'last_contact_agent_name' => 'test-value', 'sentiment' => { 'scored_conversation_count' => 1, 'positive_count' => 1, 'neutral_count' => 1, 'negative_count' => 1, 'average_sentiment_score' => 1, 'average_frustration_score' => 1, 'recent_scored_conversation_count' => 1, 'recent_positive_count' => 1, 'recent_neutral_count' => 1, 'recent_negative_count' => 1, 'recent_average_sentiment_score' => 1, 'recent_average_frustration_score' => 1 }, 'most_frustrated_conversations' => [{ 'conversation_id' => 'test-value', 'agent_id' => 'test-value', 'start_time_unix_secs' => 1, 'overall_label' => 'positive', 'overall_sentiment_score' => 1, 'overall_frustration_score' => 1 }] }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetConversationUsersPageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
