# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TicketSearchMatchResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'field' => 'title', 'snippet' => 'test-value', 'highlight_start' => 1, 'highlight_end' => 1, 'turn_index' => 1 }

    instance = ::Elevenlabs::Types::TicketSearchMatchResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
