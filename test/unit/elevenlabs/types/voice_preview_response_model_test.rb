# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoicePreviewResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'audio_base_64' => 'test-value', 'generated_voice_id' => 'test-value', 'media_type' => 'test-value', 'duration_secs' => 1, 'language' => 'test-value' }

    instance = ::Elevenlabs::Types::VoicePreviewResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
