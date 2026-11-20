# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateOAuth2ClientCredsRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'auth_type' => 'oauth2_client_credentials', 'provider' => 'test-value', 'client_id' => 'test-value', 'scopes' => ['test-value'], 'extra_params' => { 'key' => 'test-value' }, 'basic_auth_in_header' => true, 'client_secret' => 'test-value', 'custom_headers' => { 'key' => 'test-value' } }

    instance = ::Elevenlabs::Types::UpdateOAuth2ClientCredsRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
