# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationFeedbackRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'feedback' => 'like' }

    instance = ::Elevenlabs::Agents::Conversations::Feedback::Types::ConversationFeedbackRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('conversation_id'))
  end
end
