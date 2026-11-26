# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateTicketTagRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'archived' => true }

    instance = ::Elevenlabs::CustomerSupport::Tags::Types::UpdateTicketTagRequest.new(wire)

    assert_equal(wire, instance.to_h.except('tag_id'))
  end
end
