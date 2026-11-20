# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyTextToDialogueFullWithTimestampsTest < Minitest::Test
  def test_round_trip
    wire = { 'inputs' => [{ 'text' => 'test-value', 'voice_id' => 'test-value' }], 'model_id' => 'test-value', 'language_code' => 'test-value', 'settings' => { 'stability' => 0, 'similarity' => 0, 'clone_strength' => 0 }, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'seed' => 1, 'apply_text_normalization' => 'auto', 'use_pvc_as_ivc' => true, 'previous_request_ids' => ['test-value'], 'next_request_ids' => ['test-value'], 'previous_text' => 'test-value', 'future_text' => 'test-value', 'audio_effects' => { 'filter_preset_id' => 'test-value', 'distance' => 0, 'environment_id' => 'test-value', 'background_noise_id' => 'test-value', 'send_level' => 0, 'pan' => -1 } }

    instance = ::Elevenlabs::TextToDialogue::Types::BodyTextToDialogueFullWithTimestamps.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
