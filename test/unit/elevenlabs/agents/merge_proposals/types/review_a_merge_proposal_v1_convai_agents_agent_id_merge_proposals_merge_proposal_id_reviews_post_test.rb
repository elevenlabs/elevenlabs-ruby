# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyReviewAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDReviewsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'state' => 'approved', 'comment' => 'test-value' }

    instance = ::Elevenlabs::Agents::MergeProposals::Types::BodyReviewAMergeProposalV1ConvaiAgentsAgentIDMergeProposalsMergeProposalIDReviewsPost.new(wire)

    assert_equal(wire, instance.to_h.except('agent_id', 'merge_proposal_id'))
  end
end
