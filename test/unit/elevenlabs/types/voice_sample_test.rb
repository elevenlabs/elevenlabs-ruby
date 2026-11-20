# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceSampleTest < Minitest::Test
  def test_round_trip
    wire = { 'sample_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'hash' => 'test-value', 'duration_secs' => 1, 'remove_background_noise' => true, 'has_isolated_audio' => true, 'has_isolated_audio_preview' => true, 'speaker_separation' => { 'voice_id' => 'test-value', 'sample_id' => 'test-value', 'status' => 'not_started', 'speakers' => { 'key' => { 'speaker_id' => 'test-value', 'duration_secs' => 1, 'utterances' => [{ 'start' => 1, 'end' => 1 }] } }, 'selected_speaker_ids' => ['test-value'] }, 'trim_start' => 1, 'trim_end' => 1 }

    instance = ::Elevenlabs::Types::VoiceSample.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
