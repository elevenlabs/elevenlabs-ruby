# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SpeakerSegmentTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'start_time' => 1, 'end_time' => 1, 'text' => 'test-value', 'subtitles' => [{ 'start_time' => 1, 'end_time' => 1, 'lines' => ['test-value'] }], 'dubs' => { 'key' => { 'start_time' => 1, 'end_time' => 1, 'text' => 'test-value', 'subtitles' => [{ 'start_time' => 1, 'end_time' => 1, 'lines' => ['test-value'] }], 'audio_stale' => true, 'media_ref' => { 'src' => 'test-value', 'content_type' => 'test-value', 'bucket_name' => 'test-value', 'random_path_slug' => 'test-value', 'duration_secs' => 1, 'is_audio' => true, 'url' => 'test-value' } } } }

    instance = ::Elevenlabs::Types::SpeakerSegment.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
