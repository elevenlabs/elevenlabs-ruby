# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioIsolationStreamRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'audio' => 'test-value', 'file_format' => 'pcm_s16le_16' }

    instance = ::Elevenlabs::AudioIsolation::Types::AudioIsolationStreamRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
