# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RawBusinessInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'company_name' => 'test-value', 'description' => 'test-value', 'business_phone' => 'test-value', 'locations' => [{ 'name' => 'test-value', 'address' => 'test-value', 'operating_hours' => {} }], 'business_country' => 'test-value', 'business_state' => 'test-value', 'suggested_currency' => 'test-value', 'suggested_language' => 'test-value' }

    instance = ::Elevenlabs::Types::RawBusinessInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
