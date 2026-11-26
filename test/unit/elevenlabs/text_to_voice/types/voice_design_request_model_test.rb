# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceDesignRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_description' => 'test-valuetest-value', 'model_id' => 'eleven_multilingual_ttv_v2', 'text' => 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', 'auto_generate_text' => true, 'loudness' => -1, 'seed' => 0, 'guidance_scale' => 0, 'stream_previews' => true, 'should_enhance' => true, 'remixing_session_id' => 'test-value', 'remixing_session_iteration_id' => 'test-value', 'quality' => -1, 'reference_audio_base64' => 'test-value', 'prompt_strength' => 0 }

    instance = ::Elevenlabs::TextToVoice::Types::VoiceDesignRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('output_format'))
  end
end
