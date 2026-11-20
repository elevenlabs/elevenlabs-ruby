# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TeamInviteResultTest < Minitest::Test
  def test_round_trip
    wire = { 'email' => 'test-value', 'outcome' => 'invited', 'error_status' => 'test-value' }

    instance = ::Elevenlabs::Types::TeamInviteResult.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
