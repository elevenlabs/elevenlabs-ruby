# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class FileContentPartTest < Minitest::Test
  def test_round_trip
    wire = { 'type' => 'file', 'source' => { 'type' => 'base64', 'filename' => 'test-value', 'media_type' => 'image/png', 'data' => 'test-value' } }

    instance = ::Elevenlabs::Types::FileContentPart.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
