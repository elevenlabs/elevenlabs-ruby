# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyUploadMusicV1MusicUploadPostTest < Minitest::Test
  def test_round_trip
    wire = { 'file' => 'test-value', 'extract_composition_plan' => true, 'with_timestamps' => true, 'with_waveform_visual' => true }

    instance = ::Elevenlabs::Music::Types::BodyUploadMusicV1MusicUploadPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
