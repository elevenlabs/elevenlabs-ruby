# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUpdateWorkspaceWebhookV1WorkspaceWebhooksWebhookIDPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'is_disabled' => true, 'name' => 'test-value', 'retry_enabled' => true, 'request_headers' => { 'key' => 'test-value' }, 'events' => ['voice_library_removal_notice'], 'log_redacted_fields' => ['test-value'] }

    instance = ::Elevenlabs::Webhooks::Types::BodyUpdateWorkspaceWebhookV1WorkspaceWebhooksWebhookIDPatch.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
