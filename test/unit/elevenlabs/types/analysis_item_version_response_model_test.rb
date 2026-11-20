# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AnalysisItemVersionResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'version_number' => 1, 'created_at_unix_secs' => 1, 'definition' => { 'name' => 'test-value', 'source' => 'user', 'llm' => 'gpt-4o-mini', 'kind' => 'evaluation', 'conversation_goal_prompt' => 'test-value', 'use_knowledge_base' => true, 'scoring' => { 'mode' => 'binary' } } }

    instance = ::Elevenlabs::Types::AnalysisItemVersionResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
