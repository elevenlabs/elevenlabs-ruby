# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyComposeMusicWithADetailedResponseV1MusicDetailedPostTest < Minitest::Test
  def test_round_trip
    wire = { 'prompt' => 'test-value', 'composition_plan' => { 'positive_global_styles' => ['test-value'], 'negative_global_styles' => ['test-value'], 'sections' => [{ 'section_name' => 'test-value', 'positive_local_styles' => ['test-value'], 'negative_local_styles' => ['test-value'], 'duration_ms' => 3000, 'lines' => ['test-value'], 'source_from' => { 'song_id' => 'test-value', 'range' => { 'start_ms' => 1, 'end_ms' => 1 }, 'negative_ranges' => [{ 'start_ms' => 1, 'end_ms' => 1 }] } }] }, 'music_length_ms' => 3000, 'model_id' => 'music_v1', 'seed' => 0, 'force_instrumental' => true, 'finetune_id' => 'test-value', 'respect_sections_durations' => true, 'store_for_inpainting' => true, 'with_timestamps' => true, 'with_waveform_visual' => true, 'sign_with_c2pa' => true }

    instance = ::Elevenlabs::Music::Types::BodyComposeMusicWithADetailedResponseV1MusicDetailedPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
