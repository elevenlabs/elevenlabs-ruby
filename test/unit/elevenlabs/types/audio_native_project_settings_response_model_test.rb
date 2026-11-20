# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AudioNativeProjectSettingsResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'title' => 'test-value', 'image' => 'test-value', 'author' => 'test-value', 'small' => true, 'text_color' => 'test-value', 'background_color' => 'test-value', 'sessionization' => 1, 'audio_path' => 'test-value', 'audio_url' => 'test-value', 'status' => 'processing' }

    instance = ::Elevenlabs::Types::AudioNativeProjectSettingsResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
