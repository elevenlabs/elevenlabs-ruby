# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TransferToNumberResultTwilioSuccessModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'transfer_to_number_twilio_success', 'status' => 'success', 'transfer_number' => 'test-value', 'reason' => 'test-value', 'client_message' => 'test-value', 'agent_message' => 'test-value', 'conference_name' => 'test-value', 'post_dial_digits' => 'test-value', 'note' => 'test-value' }

    instance = ::Elevenlabs::Types::TransferToNumberResultTwilioSuccessModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
