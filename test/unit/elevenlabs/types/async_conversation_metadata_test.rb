# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AsyncConversationMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'delivery_status' => 'pending', 'delivery_timestamp' => 1, 'delivery_error' => 'test-value', 'external_system' => 'test-value', 'external_id' => 'test-value', 'external_link' => 'test-value', 'retry_count' => 1, 'last_retry_timestamp' => 1, 'last_processed_external_message_id' => 'test-value', 'integration_trigger_id' => 'test-value', 'platform_metadata' => { 'conversation_initiation_source' => 'plain_integration', 'thread_id' => 'test-value', 'workspace_id' => 'test-value' } }

    instance = ::Elevenlabs::Types::AsyncConversationMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
