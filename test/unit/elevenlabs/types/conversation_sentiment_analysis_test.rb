# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationSentimentAnalysisTest < Minitest::Test
  def test_round_trip
    wire = { 'overall_label' => 'positive', 'overall_sentiment_score' => -1, 'overall_frustration_score' => 0, 'min_user_sentiment_score' => -1, 'max_user_frustration_score' => 0, 'num_scored_user_turns' => 0 }

    instance = ::Elevenlabs::Types::ConversationSentimentAnalysis.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
