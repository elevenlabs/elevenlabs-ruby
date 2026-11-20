# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SingleLanguagesResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'kind' => 'single', 'languages' => [{ 'code' => 'test-value', 'label' => 'test-value' }] }

    instance = ::Elevenlabs::Types::SingleLanguagesResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
