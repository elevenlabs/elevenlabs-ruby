# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentAnalysisItemsOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'evaluation_criteria' => [{ 'source' => 'user', 'analysis_item_id' => 'test-value', 'version_id' => 'test-value', 'additional_version_ids' => ['test-value'], 'scope' => 'conversation', 'weight' => 1 }], 'data_collection' => [{ 'source' => 'user', 'analysis_item_id' => 'test-value', 'version_id' => 'test-value', 'scope' => 'conversation' }] }

    instance = ::Elevenlabs::Types::AgentAnalysisItemsOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
