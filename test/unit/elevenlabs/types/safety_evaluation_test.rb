# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SafetyEvaluationTest < Minitest::Test
  def test_round_trip
    wire = { 'is_unsafe' => true, 'llm_reason' => 'test-value', 'safety_prompt_version' => 1, 'matched_rule_id' => ['sexual_minors'] }

    instance = ::Elevenlabs::Types::SafetyEvaluation.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
