# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class MusicFinetuneResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'id' => 'test-value', 'name' => 'test-value', 'tags' => ['test-value'], 'primary_genre' => 'test-value', 'model_id' => 'test-value', 'created_at' => 'test-value', 'visibility' => 'private', 'created_by' => 'self', 'status' => 'pending', 'training_progress' => 1, 'failure_reason' => 'audio_processing_failed' }

    instance = ::Elevenlabs::Types::MusicFinetuneResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
