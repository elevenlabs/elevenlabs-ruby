# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WebhookHmacSettingsTest < Minitest::Test
  def test_round_trip
    wire = { 'auth_type' => 'hmac', 'name' => 'test-value', 'webhook_url' => 'test-value', 'request_headers' => { 'key' => 'test-value' }, 'log_redacted_fields' => ['test-value'] }

    instance = ::Elevenlabs::Types::WebhookHmacSettings.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
