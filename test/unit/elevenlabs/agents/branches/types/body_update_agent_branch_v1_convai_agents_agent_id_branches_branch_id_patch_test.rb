# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateAgentBranchV1ConvaiAgentsAgentIDBranchesBranchIDPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'description' => 'test-value', 'is_archived' => true, 'protection_status' => 'writer_perms_required', 'auto_rebase' => true }

    instance = ::Elevenlabs::Agents::Branches::Types::BodyUpdateAgentBranchV1ConvaiAgentsAgentIDBranchesBranchIDPatch.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
