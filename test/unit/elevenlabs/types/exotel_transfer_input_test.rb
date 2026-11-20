# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ExotelTransferInputTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'exotel', 'config' => { 'transfer_destination' => { 'destination' => 'test-value', 'type' => 'phone' }, 'type' => 'exotel_cold_blind_transfer' } }

    instance = ::Elevenlabs::Types::ExotelTransferInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
