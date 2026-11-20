# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InviteUserRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'email' => 'test-value', 'workspace_permission' => 'test-value', 'seat_type' => 'workspace_admin', 'group_ids' => ['test-value'], 'usage_limit' => 0 }

    instance = ::Elevenlabs::Workspace::Invites::Types::InviteUserRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
