# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyVideoToMusicV1MusicVideoToMusicPostTest < Minitest::Test
  def test_round_trip
    wire = { 'videos' => ['test-value'], 'description' => 'test-value', 'tags' => ['test-value'], 'model_id' => 'music_v1', 'add_sfx' => true, 'separate_tracks' => true, 'use_audio_as_reference' => true, 'sign_with_c2pa' => true }

    instance = ::Elevenlabs::Music::Types::BodyVideoToMusicV1MusicVideoToMusicPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
