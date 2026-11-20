# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WhatsAppCallPermissionRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'state' => 'blocked', 'requested_at_unix' => 1, 'responded_at_unix' => 1, 'permanent' => true, 'granted_by_user_call' => true }

    instance = ::Elevenlabs::Types::WhatsAppCallPermissionRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
