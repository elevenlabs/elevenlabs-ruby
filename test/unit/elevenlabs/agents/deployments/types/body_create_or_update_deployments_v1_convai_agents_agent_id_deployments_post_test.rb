# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateOrUpdateDeploymentsV1ConvaiAgentsAgentIDDeploymentsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'deployment_request' => { 'requests' => [{ 'branch_id' => 'test-value', 'deployment_strategy' => { 'type' => 'percentage', 'traffic_percentage' => 0 } }] } }

    instance = ::Elevenlabs::Agents::Deployments::Types::BodyCreateOrUpdateDeploymentsV1ConvaiAgentsAgentIDDeploymentsPost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id'))
  end
end
