# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreatePodcastV1StudioPodcastsPostTest < Minitest::Test
  def test_round_trip
    wire = { 'model_id' => 'test-value', 'mode' => { 'type' => 'conversation', 'conversation' => { 'host_voice_id' => 'test-value', 'guest_voice_id' => 'test-value' } }, 'source' => { 'type' => 'text', 'text' => 'test-value' }, 'quality_preset' => 'standard', 'duration_scale' => 'short', 'language' => 'te', 'intro' => 'test-value', 'outro' => 'test-value', 'instructions_prompt' => 'test-value', 'highlights' => ['test-value'], 'callback_url' => 'test-value', 'apply_text_normalization' => 'auto' }

    instance = ::Elevenlabs::Studio::Types::BodyCreatePodcastV1StudioPodcastsPost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
