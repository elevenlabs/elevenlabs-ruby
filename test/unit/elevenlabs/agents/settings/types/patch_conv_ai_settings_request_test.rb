# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PatchConvAiSettingsRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'conversation_initiation_client_data_webhook' => { 'url' => 'test-value', 'request_headers' => { 'key' => 'test-value' } }, 'webhooks' => { 'post_call_webhook_id' => 'test-value', 'events' => ['transcript'], 'transcript_format' => 'json', 'exclude_transcript' => true, 'send_audio' => true }, 'can_use_mcp_servers' => true, 'rag_retention_period_days' => 30, 'conversation_embedding_retention_days' => 365, 'default_livekit_stack' => 'standard' }

    instance = ::Elevenlabs::Agents::Settings::Types::PatchConvAiSettingsRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
