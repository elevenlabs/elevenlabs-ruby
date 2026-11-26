# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'source_branch_id' => 'test-value', 'target_branch_id' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'requested_reviewer_user_ids' => ['test-value'], 'triage_ticket_id' => 'test-value' }

    instance = ::Elevenlabs::Agents::MergeProposals::Types::BodyCreateAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsPost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id'))
  end
end
