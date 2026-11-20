# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryEvaluationCriteriaResultCommonModelTest < Minitest::Test
  def test_round_trip
    wire = { 'criteria_id' => 'test-value', 'result' => 'success', 'rationale' => 'test-value', 'scoring_mode' => 'binary', 'score' => 1, 'max_score' => 1 }

    instance = ::Elevenlabs::Types::ConversationHistoryEvaluationCriteriaResultCommonModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
