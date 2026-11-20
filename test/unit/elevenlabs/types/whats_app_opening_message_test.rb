# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class WhatsAppOpeningMessageTest < Minitest::Test
  def test_round_trip
    wire = { 'template_name' => 'test-value', 'wamid' => 'test-value', 'sent_at_unix' => 1, 'delivered_at_unix' => 1, 'read_at_unix' => 1, 'replied_at_unix' => 1, 'failed_at_unix' => 1, 'error_code' => 'test-value', 'pricing_category' => 'test-value', 'billable' => true }

    instance = ::Elevenlabs::Types::WhatsAppOpeningMessage.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
