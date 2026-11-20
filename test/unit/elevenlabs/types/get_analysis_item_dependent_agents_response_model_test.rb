# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetAnalysisItemDependentAgentsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'agents' => [{ 'referenced_resource_ids' => ['test-value'], 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'branches' => [{ 'agent_id' => 'test-value', 'agent_name' => 'test-value', 'branch_id' => 'test-value', 'branch_name' => 'test-value', 'is_main' => true }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::GetAnalysisItemDependentAgentsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
