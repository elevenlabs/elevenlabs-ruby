# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryFeedbackCommonModelTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'thumbs', 'overall_score' => 'like', 'likes' => 1, 'dislikes' => 1, 'rating' => 1, 'comment' => 'test-value' }

    instance = ::Elevenlabs::Types::ConversationHistoryFeedbackCommonModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
