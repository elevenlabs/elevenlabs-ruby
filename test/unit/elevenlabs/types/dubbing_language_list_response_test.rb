# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingLanguageListResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'languages' => [{ 'language_id' => 'test-value', 'project_id' => 'test-value', 'target_language' => 'test-value', 'status' => 'queued', 'model_id' => 'test-value', 'voice_settings' => { 'cloning_strength' => 0 }, 'outputs' => { 'lossless_audio' => 'test-value', 'subtitles' => 'test-value' }, 'revision' => 1, 'output_revision' => 1, 'error' => { 'code' => 'test-value', 'message' => 'test-value', 'retryable' => true }, 'warnings' => [{ 'type' => 'voices_not_permitted', 'speaker_ids' => ['test-value'], 'message' => 'test-value' }], 'created_at' => 'test-value', 'updated_at' => 'test-value' }], 'next_cursor' => 'test-value' }

    instance = ::Elevenlabs::Types::DubbingLanguageListResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
