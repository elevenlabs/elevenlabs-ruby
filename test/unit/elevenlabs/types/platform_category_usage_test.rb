# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PlatformCategoryUsageTest < Minitest::Test
  def test_round_trip
    wire = { 'credits' => 1, 'price' => 1, 'quantity' => 1 }

    instance = ::Elevenlabs::Types::PlatformCategoryUsage.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
