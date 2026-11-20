# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateAgentDraftV1ConvaiAgentsAgentIDDraftsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_config' => {}, 'platform_settings' => {}, 'workflow' => { 'edges' => { 'key' => { 'source' => 'test-value', 'target' => 'test-value', 'forward_condition' => { 'label' => 'test-value', 'type' => 'unconditional' }, 'backward_condition' => { 'label' => 'test-value', 'type' => 'unconditional' }, 'reroutes' => [{ 'x' => 1, 'y' => 1 }] } }, 'nodes' => { 'key' => { 'type' => 'start', 'position' => { 'x' => 1, 'y' => 1 }, 'edge_order' => ['test-value'] } }, 'prevent_subagent_loops' => true }, 'name' => 'test-value', 'tags' => ['test-value'] }

    instance = ::Elevenlabs::Agents::Drafts::Types::BodyCreateAgentDraftV1ConvaiAgentsAgentIDDraftsPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
