# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ClientErrorErrorEventTest < Minitest::Test
  def test_round_trip
    wire = { 'code' => 1, 'error_name' => 'test-value', 'message' => 'test-value' }

    instance = ::Elevenlabs::Types::ClientErrorErrorEvent.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
