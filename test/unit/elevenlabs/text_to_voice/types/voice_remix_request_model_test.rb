# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceRemixRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_description' => 'test-value', 'text' => 'test-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-valuetest-value', 'auto_generate_text' => true, 'loudness' => -1, 'seed' => 0, 'guidance_scale' => 0, 'stream_previews' => true, 'remixing_session_id' => 'test-value', 'remixing_session_iteration_id' => 'test-value', 'prompt_strength' => 0 }

    instance = ::Elevenlabs::TextToVoice::Types::VoiceRemixRequestModel.new(wire)

    assert_equal(wire, instance.to_h.except('voice_id', 'output_format'))
  end
end
