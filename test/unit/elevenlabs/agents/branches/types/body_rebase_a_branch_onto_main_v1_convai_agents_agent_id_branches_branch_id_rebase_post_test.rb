# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyRebaseABranchOntoMainV1ConvaiAgentsAgentIDBranchesBranchIDRebasePostTest < Minitest::Test
  def test_round_trip
    wire = { 'conflict_resolutions' => [{ 'conflict_id' => 'test-value', 'choice' => 'source', 'custom_value' => 'test-value' }], 'branch_tip_id' => 'test-value', 'source_tip_id' => 'test-value' }

    instance = ::Elevenlabs::Agents::Branches::Types::BodyRebaseABranchOntoMainV1ConvaiAgentsAgentIDBranchesBranchIDRebasePost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id', 'branch_id', 'source_branch_id'))
  end
end
