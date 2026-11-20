# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MusicExploreSongSourceContextTest < Minitest::Test
  def test_round_trip
    wire = { 'source_type' => 'music_explore_song', 'music_explore_song_id' => 'test-value', 'title' => 'test-value', 'description' => 'test-value', 'bpm' => 1, 'vocals' => 'test-value', 'lyrics' => 'test-value' }

    instance = ::Elevenlabs::Types::MusicExploreSongSourceContext.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
