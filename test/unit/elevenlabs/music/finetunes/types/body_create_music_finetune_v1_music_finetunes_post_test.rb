# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreateMusicFinetuneV1MusicFinetunesPostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'primary_genre' => 'test-value', 'files' => ['test-value'], 'tags' => ['test-value'], 'visibility' => 'private', 'model_id' => 'music_v1' }

    instance = ::Elevenlabs::Music::Finetunes::Types::BodyCreateMusicFinetuneV1MusicFinetunesPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
