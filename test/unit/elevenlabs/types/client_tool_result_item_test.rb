# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ClientToolResultItemTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'client_tool_result', 'tool_call_id' => 'test-value', 'result' => 'test-value', 'is_error' => true, 'error_type' => 'user_rejected' }

    instance = ::Elevenlabs::Types::ClientToolResultItem.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
