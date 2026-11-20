# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AuthConnectionDependenciesTest < Minitest::Test
  def test_round_trip
    wire = { 'tools' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'mcp_servers' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'integration_connections' => [{ 'id' => 'test-value', 'name' => 'test-value' }] }

    instance = ::Elevenlabs::Types::AuthConnectionDependencies.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
