# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WorkspaceWebhookListResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'webhooks' => [{ 'name' => 'test-value', 'webhook_id' => 'test-value', 'webhook_url' => 'test-value', 'is_disabled' => true, 'is_auto_disabled' => true, 'created_at_unix' => 1, 'auth_type' => 'hmac', 'usage' => [{ 'usage_type' => 'ConvAI Agent Settings' }], 'events' => ['voice_library_removal_notice'], 'most_recent_failure_error_code' => 1, 'most_recent_failure_timestamp' => 1 }] }

    instance = ::Elevenlabs::Types::WorkspaceWebhookListResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
