# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TtsConversationalConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'expressive_mode' => true, 'suggested_audio_tags' => [{ 'tag' => 'test-value', 'description' => 'test-value' }], 'agent_output_audio_format' => 'pcm_8000', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0, 'text_normalisation_type' => 'system_prompt', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'enable_phoneme_tags' => true, 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }

    instance = ::Elevenlabs::Types::TtsConversationalConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
