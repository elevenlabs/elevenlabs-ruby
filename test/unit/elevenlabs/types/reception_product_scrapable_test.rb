# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionProductScrapableTest < Minitest::Test
  def test_round_trip
    wire = { 'pricing_mode' => 'fixed', 'groups' => [{ 'label' => 'test-value', 'rank' => 0 }], 'ungrouped_rank' => 0, 'name' => 'test-value', 'description' => 'test-value', 'price' => 0 }

    instance = ::Elevenlabs::Types::ReceptionProductScrapable.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
