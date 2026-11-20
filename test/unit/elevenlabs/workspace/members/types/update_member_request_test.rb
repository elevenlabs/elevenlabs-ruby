# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateMemberRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'email' => 'test-value', 'is_locked' => true, 'workspace_role' => 'workspace_admin', 'workspace_seat_type' => 'workspace_admin', 'allow_downgrade_to_basic_seat' => true }

    instance = ::Elevenlabs::Workspace::Members::Types::UpdateMemberRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
