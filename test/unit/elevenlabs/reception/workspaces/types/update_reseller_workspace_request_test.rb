# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateResellerWorkspaceRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'metadata' => { 'key' => 'test-value' } }

    instance = ::Elevenlabs::Reception::Workspaces::Types::UpdateResellerWorkspaceRequest.new(wire)

    assert_equal(wire, instance.to_h.except('workspace_id'))
  end
end
