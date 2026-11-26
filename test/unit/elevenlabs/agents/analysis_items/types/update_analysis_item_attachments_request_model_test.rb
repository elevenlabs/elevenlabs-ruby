# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateAnalysisItemAttachmentsRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'source' => 'user', 'attach' => [{ 'agent_id' => 'test-value', 'branch_id' => 'test-value' }], 'detach' => [{ 'agent_id' => 'test-value', 'branch_id' => 'test-value' }] }

    instance = ::Elevenlabs::Agents::AnalysisItems::Types::UpdateAnalysisItemAttachmentsRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('analysis_item_id'))
  end
end
