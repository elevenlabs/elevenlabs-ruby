# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SpeakerTrackTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'media_ref' => { 'src' => 'test-value', 'content_type' => 'test-value', 'bucket_name' => 'test-value', 'random_path_slug' => 'test-value', 'duration_secs' => 1, 'is_audio' => true, 'url' => 'test-value' }, 'speaker_name' => 'test-value', 'voices' => { 'key' => 'test-value' }, 'segments' => ['test-value'] }

    instance = ::Elevenlabs::Types::SpeakerTrack.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
