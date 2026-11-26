# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class CreateTicketMessageRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'author' => { 'type' => 'requester' }, 'body' => 'test-value', 'visibility' => 'public', 'status' => 'open' }

    instance = ::Elevenlabs::CustomerSupport::Tickets::Types::CreateTicketMessageRequest.new(wire)

    assert_equal(wire, instance.to_h.except('ticket_id'))
  end
end
