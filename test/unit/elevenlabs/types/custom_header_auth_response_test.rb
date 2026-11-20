# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CustomHeaderAuthResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'auth_type' => 'custom_header_auth', 'provider' => 'test-value', 'header_name' => 'test-value', 'id' => 'test-value', 'used_by' => { 'tools' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'mcp_servers' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'integration_connections' => [{ 'id' => 'test-value', 'name' => 'test-value' }] }, 'status' => 'active', 'status_detail' => 'test-value', 'status_updated_at' => 'test-value' }

    instance = ::Elevenlabs::Types::CustomHeaderAuthResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
