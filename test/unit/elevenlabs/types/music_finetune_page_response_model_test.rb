# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MusicFinetunePageResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'finetunes' => [{ 'id' => 'test-value', 'name' => 'test-value', 'tags' => ['test-value'], 'primary_genre' => 'test-value', 'model_id' => 'test-value', 'created_at' => 'test-value', 'visibility' => 'private', 'created_by' => 'self', 'status' => 'pending', 'training_progress' => 1, 'failure_reason' => 'audio_processing_failed' }], 'next_cursor' => 'test-value', 'has_more' => true }

    instance = ::Elevenlabs::Types::MusicFinetunePageResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
