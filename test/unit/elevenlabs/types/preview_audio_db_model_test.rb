# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PreviewAudioDbModelTest < Minitest::Test
  def test_round_trip
    wire = { 'voice_id' => 'test-value', 'text' => 'test-value', 'audio_url' => 'test-value', 'hls_manifest_url' => 'test-value', 'dash_manifest_url' => 'test-value', 'is_auto_generated' => true, 'generated_at_unix' => 1 }

    instance = ::Elevenlabs::Types::PreviewAudioDbModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
