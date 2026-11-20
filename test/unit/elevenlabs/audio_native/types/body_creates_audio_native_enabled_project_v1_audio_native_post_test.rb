# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyCreatesAudioNativeEnabledProjectV1AudioNativePostTest < Minitest::Test
  def test_round_trip
    wire = { 'name' => 'test-value', 'image' => 'test-value', 'author' => 'test-value', 'title' => 'test-value', 'small' => true, 'text_color' => 'test-value', 'background_color' => 'test-value', 'sessionization' => 1, 'voice_id' => 'test-value', 'model_id' => 'test-value', 'file' => 'test-value', 'auto_convert' => true, 'apply_text_normalization' => 'auto', 'pronunciation_dictionary_locators' => ['test-value'] }

    instance = ::Elevenlabs::AudioNative::Types::BodyCreatesAudioNativeEnabledProjectV1AudioNativePost.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
