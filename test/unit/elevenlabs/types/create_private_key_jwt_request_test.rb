# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreatePrivateKeyJwtRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'auth_type' => 'private_key_jwt', 'provider' => 'test-value', 'algorithm' => 'HS256', 'key_id' => 'test-value', 'issuer' => 'test-value', 'audience' => 'test-value', 'subject' => 'test-value', 'expiration_seconds' => 60, 'extra_params' => { 'key' => 'test-value' }, 'extra_headers' => { 'key' => 'test-value' }, 'secret_key' => 'test-value' }

    instance = ::Elevenlabs::Types::CreatePrivateKeyJwtRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
