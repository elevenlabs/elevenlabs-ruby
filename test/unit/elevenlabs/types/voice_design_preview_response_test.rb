# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class VoiceDesignPreviewResponseTest < Minitest::Test
  def test_round_trip
    wire = { 'previews' => [{ 'audio_base_64' => 'test-value', 'generated_voice_id' => 'test-value', 'media_type' => 'test-value', 'duration_secs' => 1, 'language' => 'test-value' }], 'text' => 'test-value' }

    instance = ::Elevenlabs::Types::VoiceDesignPreviewResponse.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
