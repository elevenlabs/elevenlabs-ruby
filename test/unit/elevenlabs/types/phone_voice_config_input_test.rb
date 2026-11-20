# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PhoneVoiceConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'ringing_timeout_secs' => 1, 'twilio_call_recording_enabled' => true, 'twilio_machine_detection' => { 'mode' => 'enable', 'actions' => [{ 'action' => 'hang_up', 'answered_by' => ['human'] }] }, 'mode' => 'voice' }

    instance = ::Elevenlabs::Types::PhoneVoiceConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
