# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AnalysisItemResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'definition' => { 'name' => 'test-value', 'source' => 'user', 'llm' => 'gpt-4o-mini', 'kind' => 'evaluation', 'conversation_goal_prompt' => 'test-value', 'use_knowledge_base' => true, 'scoring' => { 'mode' => 'binary' } }, 'access_info' => { 'is_creator' => true, 'creator_name' => 'test-value', 'creator_email' => 'test-value', 'role' => 'admin', 'anonymous_access_level_override' => 'admin', 'access_source' => 'creator' }, 'created_at_unix_secs' => 1, 'updated_at_unix_secs' => 1, 'current_version_id' => 'test-value', 'legacy_source_id' => 'test-value' }

    instance = ::Elevenlabs::Types::AnalysisItemResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
