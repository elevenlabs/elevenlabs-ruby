# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class FineTuningResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'is_allowed_to_fine_tune' => true, 'state' => { 'key' => 'not_started' }, 'verification_failures' => ['test-value'], 'verification_attempts_count' => 1, 'manual_verification_requested' => true, 'language' => 'test-value', 'progress' => { 'key' => 1 }, 'message' => { 'key' => 'test-value' }, 'dataset_duration_seconds' => 1, 'verification_attempts' => [{ 'text' => 'test-value', 'date_unix' => 1, 'accepted' => true, 'similarity' => 1, 'levenshtein_distance' => 1, 'recording' => { 'recording_id' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1, 'transcription' => 'test-value' } }], 'slice_ids' => ['test-value'], 'manual_verification' => { 'extra_text' => 'test-value', 'request_time_unix' => 1, 'files' => [{ 'file_id' => 'test-value', 'file_name' => 'test-value', 'mime_type' => 'test-value', 'size_bytes' => 1, 'upload_date_unix' => 1 }] }, 'max_verification_attempts' => 1, 'next_max_verification_attempts_reset_unix_ms' => 1, 'finetuning_state' => {} }

    instance = ::Elevenlabs::Types::FineTuningResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
