# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryAnalysisCommonModelTest < Minitest::Test
  def test_round_trip
    wire = { 'evaluation_criteria_results' => { 'key' => { 'criteria_id' => 'test-value', 'result' => 'success', 'rationale' => 'test-value', 'scoring_mode' => 'binary', 'score' => 1, 'max_score' => 1 } }, 'data_collection_results' => { 'key' => { 'data_collection_id' => 'test-value', 'name' => 'test-value', 'value' => {}, 'json_schema' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true }, 'rationale' => 'test-value' } }, 'evaluation_criteria_results_list' => [{ 'criteria_id' => 'test-value', 'result' => 'success', 'rationale' => 'test-value', 'scoring_mode' => 'binary', 'score' => 1, 'max_score' => 1 }], 'data_collection_results_list' => [{ 'data_collection_id' => 'test-value', 'name' => 'test-value', 'value' => {}, 'json_schema' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true }, 'rationale' => 'test-value' }], 'call_successful' => 'success', 'call_success_score' => 1, 'transcript_summary' => 'test-value', 'call_summary_title' => 'test-value', 'scoped' => [{ 'scope' => 'conversation', 'source_agent_id' => 'test-value', 'source_branch_id' => 'test-value', 'evaluation_criteria_results' => { 'key' => { 'criteria_id' => 'test-value', 'result' => 'success', 'rationale' => 'test-value', 'scoring_mode' => 'binary', 'score' => 1, 'max_score' => 1 } }, 'data_collection_results' => { 'key' => { 'data_collection_id' => 'test-value', 'name' => 'test-value', 'value' => {}, 'json_schema' => { 'type' => 'boolean', 'description' => 'test-value', 'enum' => ['test-value'], 'is_system_provided' => true, 'dynamic_variable' => 'test-value', 'allowed_values' => { 'dynamic_variable' => 'test-value' }, 'allowed_values_dynamic_variable' => 'test-value', 'constant_value' => 'test-value', 'is_omitted' => true }, 'rationale' => 'test-value' } }, 'successful' => 'success', 'success_score' => 1 }] }

    instance = ::Elevenlabs::Types::ConversationHistoryAnalysisCommonModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
