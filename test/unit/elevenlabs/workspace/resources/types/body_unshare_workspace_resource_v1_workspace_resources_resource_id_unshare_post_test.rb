# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUnshareWorkspaceResourceV1WorkspaceResourcesResourceIDUnsharePostTest < Minitest::Test
  def test_round_trip
    wire = { 'resource_type' => 'voice', 'user_email' => 'test-value', 'group_id' => 'test-value', 'workspace_api_key_id' => 'test-value' }

    instance = ::Elevenlabs::Workspace::Resources::Types::BodyUnshareWorkspaceResourceV1WorkspaceResourcesResourceIDUnsharePost.new(wire)

    assert_equal(wire, instance.to_h.except('resource_id'))
  end
end
