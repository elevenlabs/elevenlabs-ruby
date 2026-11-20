# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetAgentTopicsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'topics' => [{ 'topic_id' => 'test-value', 'label' => 'test-value', 'description' => 'test-value', 'conversation_count' => 1, 'parent_topic_id' => 'test-value', 'x_2d' => 1, 'y_2d' => 1, 'metrics' => { 'conversation_count' => 1, 'sentiment' => { 'sentiment' => { 'count' => 1, 'sum' => 1, 'min' => 1, 'max' => 1 }, 'frustration' => { 'count' => 1, 'sum' => 1, 'min' => 1, 'max' => 1 }, 'positive_count' => 1, 'neutral_count' => 1, 'negative_count' => 1 }, 'evaluation_criteria' => [{ 'criteria_id' => 'test-value', 'success_count' => 1, 'failure_count' => 1, 'unknown_count' => 1 }] }, 'success_rate' => 1 }], 'window_start_unix_secs' => 1, 'window_end_unix_secs' => 1, 'aggregated_run_count' => 1, 'has_more' => true, 'next_cursor' => 'test-value' }

    instance = ::Elevenlabs::Types::GetAgentTopicsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
