# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class EvaluationSettingsOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'criteria' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'prompt', 'conversation_goal_prompt' => 'test-value', 'use_knowledge_base' => true, 'scope' => 'conversation', 'llm' => 'gpt-4o-mini', 'scoring_mode' => 'binary', 'max_score' => 1, 'score_instructions' => 'test-value' }] }

    instance = ::Elevenlabs::Types::EvaluationSettingsOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
