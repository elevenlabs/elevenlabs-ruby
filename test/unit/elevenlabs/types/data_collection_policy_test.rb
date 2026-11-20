# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DataCollectionPolicyTest < Minitest::Test
  def test_round_trip
    wire = { 'callback_time' => 'test-value', 'redirect_phone_number' => 'test-value', 'stop' => 'test-value', 'mappings' => { 'key' => 'test-value' } }

    instance = ::Elevenlabs::Types::DataCollectionPolicy.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
