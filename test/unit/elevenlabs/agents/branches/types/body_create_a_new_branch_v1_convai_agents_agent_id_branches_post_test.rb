# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateANewBranchV1ConvaiAgentsAgentIDBranchesPostTest < Minitest::Test
  def test_round_trip
    wire = { 'parent_version_id' => 'test-value', 'name' => 'test-value', 'description' => 'test-value', 'conversation_config' => {}, 'platform_settings' => {}, 'workflow' => { 'edges' => { 'key' => { 'source' => 'test-value', 'target' => 'test-value', 'forward_condition' => { 'label' => 'test-value', 'type' => 'unconditional' }, 'backward_condition' => { 'label' => 'test-value', 'type' => 'unconditional' }, 'reroutes' => [{ 'x' => 1, 'y' => 1 }] } }, 'nodes' => { 'key' => { 'type' => 'start', 'position' => { 'x' => 1, 'y' => 1 }, 'edge_order' => ['test-value'] } }, 'prevent_subagent_loops' => true }, 'include_draft' => true }

    instance = ::Elevenlabs::Agents::Branches::Types::BodyCreateANewBranchV1ConvaiAgentsAgentIDBranchesPost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id'))
  end
end
