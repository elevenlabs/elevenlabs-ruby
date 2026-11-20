# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class OutboundSipTrunkConfigRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'address' => 'test-value', 'transport' => 'auto', 'media_encryption' => 'disabled', 'headers' => { 'key' => 'test-value' }, 'attributes_to_headers' => { 'key' => 'test-value' }, 'credentials' => { 'username' => 'test-value', 'password' => 'test-value' }, 'enabled_codecs' => ['G722/8000'] }

    instance = ::Elevenlabs::Types::OutboundSipTrunkConfigRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
