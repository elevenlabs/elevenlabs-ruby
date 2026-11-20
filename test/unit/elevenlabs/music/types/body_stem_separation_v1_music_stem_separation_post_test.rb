# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyStemSeparationV1MusicStemSeparationPostTest < Minitest::Test
  def test_round_trip
    wire = { 'file' => 'test-value', 'stem_variation_id' => 'two_stems_v1', 'sign_with_c2pa' => true }

    instance = ::Elevenlabs::Music::Types::BodyStemSeparationV1MusicStemSeparationPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
