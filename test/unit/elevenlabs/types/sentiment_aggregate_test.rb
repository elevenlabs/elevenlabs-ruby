# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SentimentAggregateTest < Minitest::Test
  def test_round_trip
    wire = { 'scored_conversation_count' => 1, 'positive_count' => 1, 'neutral_count' => 1, 'negative_count' => 1, 'average_sentiment_score' => 1, 'average_frustration_score' => 1, 'recent_scored_conversation_count' => 1, 'recent_positive_count' => 1, 'recent_neutral_count' => 1, 'recent_negative_count' => 1, 'recent_average_sentiment_score' => 1, 'recent_average_frustration_score' => 1 }

    instance = ::Elevenlabs::Types::SentimentAggregate.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
