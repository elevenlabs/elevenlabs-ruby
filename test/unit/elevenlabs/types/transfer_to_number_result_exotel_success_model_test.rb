# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TransferToNumberResultExotelSuccessModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'transfer_to_number_exotel_success', 'status' => 'success', 'transfer_number' => 'test-value', 'reason' => 'test-value', 'agent_message' => 'test-value', 'note' => 'test-value' }

    instance = ::Elevenlabs::Types::TransferToNumberResultExotelSuccessModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
