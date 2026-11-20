# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateAnalysisItemAttachmentsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'results' => [{ 'status' => 'success', 'data' => { 'agent_id' => 'test-value', 'branch_id' => 'test-value', 'action' => 'attach', 'changed' => true } }] }

    instance = ::Elevenlabs::Types::UpdateAnalysisItemAttachmentsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
