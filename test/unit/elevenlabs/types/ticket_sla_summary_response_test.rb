# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TicketSLASummaryResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'metric' => 'first_response', 'duration_secs' => 1, 'started_at_unix_secs' => 1, 'due_at_unix_secs' => 1 }

    instance = ::Elevenlabs::Types::TicketSLASummaryResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
