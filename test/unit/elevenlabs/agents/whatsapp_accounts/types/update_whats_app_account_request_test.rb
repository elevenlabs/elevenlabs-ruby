# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateWhatsAppAccountRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'assigned_agent_id' => 'test-value', 'enable_messaging' => true, 'enable_audio_message_response' => true, 'enable_typing_indicator' => true }

    instance = ::Elevenlabs::Agents::WhatsappAccounts::Types::UpdateWhatsAppAccountRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
