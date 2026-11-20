# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationHistoryTranscriptToolCallAPIIntegrationWebhookDetailsInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'api_integration_webhook', 'integration_id' => 'test-value', 'credential_id' => 'test-value', 'integration_connection_id' => 'test-value', 'webhook_details' => { 'type' => 'webhook', 'method' => 'test-value', 'url' => 'test-value', 'headers' => { 'key' => 'test-value' }, 'path_params' => { 'key' => 'test-value' }, 'query_params' => { 'key' => 'test-value' }, 'body' => 'test-value' }, 'function_details' => { 'resolved_parameters' => { 'key' => 'test-value' } } }

    instance = ::Elevenlabs::Types::ConversationHistoryTranscriptToolCallAPIIntegrationWebhookDetailsInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
