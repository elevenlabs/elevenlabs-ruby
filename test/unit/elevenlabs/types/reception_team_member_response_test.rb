# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionTeamMemberResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'user_id' => 'test-value', 'email' => 'test-value', 'first_name' => 'test-value', 'is_owner' => true, 'is_admin' => true, 'picture_url' => 'test-value', 'is_suspended' => true }

    instance = ::Elevenlabs::Types::ReceptionTeamMemberResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
