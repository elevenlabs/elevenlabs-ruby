# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SessionStartedConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'sample_rate' => 1, 'audio_format' => 'pcm_8000', 'language_code' => 'test-value', 'secondary_languages' => ['test-value'], 'timestamps_granularity' => 'none', 'vad_commit_strategy' => true, 'vad_silence_threshold_secs' => 1, 'vad_threshold' => 1, 'min_speech_duration_ms' => 1, 'min_silence_duration_ms' => 1, 'max_tokens_to_recompute' => 1, 'model_id' => 'scribe_v2_realtime', 'disable_logging' => true, 'include_timestamps' => true, 'include_language_detection' => true, 'filter_background_audio' => true, 'keyterms' => ['test-value'], 'no_verbatim' => true, 'entity_detection' => ['test-value'], 'entity_redaction' => ['test-value'], 'entity_redaction_mode' => 'test-value', 'keepalive_interval_ms' => 1 }

    instance = ::Elevenlabs::Types::SessionStartedConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
