# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SmbClientAccessConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'enable_secure_mode' => true, 'identity_verification_enabled' => true, 'identity_verification_email_enabled' => true, 'identity_verification_sms_enabled' => true }

    instance = ::Elevenlabs::Types::SmbClientAccessConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
