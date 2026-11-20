# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TicketStatusChangeResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'status' => 'open', 'changed_by_user_id' => 'test-value', 'changed_at_unix_secs' => 1 }

    instance = ::Elevenlabs::Types::TicketStatusChangeResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
