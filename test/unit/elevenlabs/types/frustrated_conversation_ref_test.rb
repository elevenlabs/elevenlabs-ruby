# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class FrustratedConversationRefTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_id' => 'test-value', 'agent_id' => 'test-value', 'start_time_unix_secs' => 1, 'overall_label' => 'positive', 'overall_sentiment_score' => 1, 'overall_frustration_score' => 1 }

    instance = ::Elevenlabs::Types::FrustratedConversationRef.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
