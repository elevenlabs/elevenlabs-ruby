# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioWithTimestampsAndVoiceSegmentsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'audio_base64' => 'test-value', 'alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] }, 'normalized_alignment' => { 'characters' => ['test-value'], 'character_start_times_seconds' => [1], 'character_end_times_seconds' => [1] }, 'voice_segments' => [{ 'voice_id' => 'test-value', 'start_time_seconds' => 1, 'end_time_seconds' => 1, 'character_start_index' => 1, 'character_end_index' => 1, 'dialogue_input_index' => 1 }] }

    instance = ::Elevenlabs::Types::AudioWithTimestampsAndVoiceSegmentsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
