# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodySpeechToTextV1SpeechToTextPostTest < Minitest::Test
  def test_round_trip
    wire = { 'model_id' => 'test-value', 'file' => 'test-value', 'language_code' => 'test-value', 'secondary_language_codes' => ['test-value'], 'numbers_format' => 'digits', 'transcript_edit' => 'test-value', 'tag_audio_events' => true, 'num_speakers' => 1, 'timestamps_granularity' => 'none', 'diarize' => true, 'diarization_threshold' => 0.1, 'additional_formats' => [{ 'include_speakers' => true, 'include_timestamps' => true, 'format' => 'segmented_json', 'segment_on_silence_longer_than_s' => 1, 'max_segment_duration_s' => 1, 'max_segment_chars' => 1 }], 'file_format' => 'pcm_s16le_16', 'source_url' => 'test-value', 'webhook' => true, 'webhook_id' => 'test-value', 'temperature' => 0, 'seed' => 0, 'use_multi_channel' => true, 'multichannel_output_style' => 'separate', 'webhook_metadata' => 'test-value', 'entity_detection' => 'test-value', 'no_verbatim' => true, 'use_speaker_library' => true, 'detect_speaker_roles' => true, 'entity_redaction' => 'test-value', 'entity_redaction_mode' => 'test-value', 'keyterms' => ['test-value'] }

    instance = ::Elevenlabs::SpeechToText::Types::BodySpeechToTextV1SpeechToTextPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
