# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class SpeechToSpeechStreamRequestTest < Minitest::Test
  def test_round_trip
    wire = { 'audio' => 'test-value', 'model_id' => 'test-value', 'voice_settings' => 'test-value', 'seed' => 1, 'remove_background_noise' => true, 'file_format' => 'pcm_s16le_16' }

    instance = ::Elevenlabs::SpeechToSpeech::Types::SpeechToSpeechStreamRequest.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
