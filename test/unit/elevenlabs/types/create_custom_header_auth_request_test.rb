# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateCustomHeaderAuthRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'auth_type' => 'custom_header_auth', 'provider' => 'test-value', 'header_name' => 'test-value', 'token' => 'test-value' }

    instance = ::Elevenlabs::Types::CreateCustomHeaderAuthRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
