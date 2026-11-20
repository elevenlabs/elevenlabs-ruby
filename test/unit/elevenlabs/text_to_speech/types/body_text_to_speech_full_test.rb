# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyTextToSpeechFullTest < Minitest::Test
  def test_round_trip
    wire = { 'text' => 'test-value', 'model_id' => 'test-value', 'language_code' => 'test-value', 'voice_settings' => { 'stability' => 0, 'use_speaker_boost' => true, 'similarity_boost' => 0, 'style' => 1, 'speed' => 1, 'clone_strength' => 0 }, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'seed' => 1, 'previous_text' => 'test-value', 'next_text' => 'test-value', 'previous_request_ids' => ['test-value'], 'next_request_ids' => ['test-value'], 'use_pvc_as_ivc' => true, 'apply_text_normalization' => 'auto', 'apply_language_text_normalization' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }

    instance = ::Elevenlabs::TextToSpeech::Types::BodyTextToSpeechFull.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
