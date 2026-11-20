# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InboundSipTrunkConfigRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'allowed_addresses' => ['test-value'], 'allowed_numbers' => ['test-value'], 'media_encryption' => 'disabled', 'credentials' => { 'username' => 'test-value', 'password' => 'test-value' }, 'remote_domains' => ['test-value'], 'attributes_to_headers' => { 'key' => 'test-value' } }

    instance = ::Elevenlabs::Types::InboundSipTrunkConfigRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
