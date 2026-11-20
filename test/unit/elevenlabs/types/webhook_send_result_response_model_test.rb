# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WebhookSendResultResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'delivery_id' => 'test-value', 'outcome' => 'delivered', 'response_code' => 1, 'latency_ms' => 1, 'response_content_type' => 'test-value', 'response_body_bytes' => 1, 'failure_origin' => 'test-value' }

    instance = ::Elevenlabs::Types::WebhookSendResultResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
