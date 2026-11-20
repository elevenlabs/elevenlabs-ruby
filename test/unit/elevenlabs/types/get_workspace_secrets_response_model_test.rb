# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GetWorkspaceSecretsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'secrets' => [{ 'type' => 'stored', 'secret_id' => 'test-value', 'name' => 'test-value', 'used_by' => { 'tools' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'tools_has_more' => true, 'agents' => [{ 'referenced_resource_ids' => ['test-value'], 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'agents_has_more' => true, 'phone_numbers' => [{ 'phone_number_id' => 'test-value', 'phone_number' => 'test-value', 'label' => 'test-value', 'provider' => 'twilio' }], 'phone_numbers_has_more' => true, 'mcp_servers' => [{ 'id' => 'test-value', 'name' => 'test-value', 'type' => 'available', 'created_at_unix_secs' => 1, 'access_level' => 'admin' }], 'others' => ['conversation_initiation_webhook'] } }], 'next_cursor' => 'test-value' }

    instance = ::Elevenlabs::Types::GetWorkspaceSecretsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
