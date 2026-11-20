# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ResponseFilterTest < Minitest::Test
  def test_round_trip
    wire = { 'mode' => 'all', 'filters' => ['test-value'], 'content_type' => 'application/json' }

    instance = ::Elevenlabs::Types::ResponseFilter.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
