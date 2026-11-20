# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SendTextGenerationConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'chunk_length_schedule' => [1] }

    instance = ::Elevenlabs::Types::SendTextGenerationConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
