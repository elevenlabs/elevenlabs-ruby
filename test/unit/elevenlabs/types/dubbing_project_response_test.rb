# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class DubbingProjectResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'project_id' => 'test-value', 'status' => 'queued', 'reference' => 'test-value', 'source_language' => 'test-value', 'model_id' => 'test-value', 'media' => { 'filename' => 'test-value', 'duration_s' => 1, 'has_video' => true, 'mime_type' => 'test-value' }, 'language_ids' => ['test-value'], 'webhook_ids' => ['test-value'], 'revision' => 1, 'error' => { 'code' => 'test-value', 'message' => 'test-value', 'retryable' => true }, 'warnings' => [{ 'type' => 'voices_not_permitted', 'speaker_ids' => ['test-value'], 'message' => 'test-value' }], 'created_at' => 'test-value', 'updated_at' => 'test-value' }

    instance = ::Elevenlabs::Types::DubbingProjectResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
