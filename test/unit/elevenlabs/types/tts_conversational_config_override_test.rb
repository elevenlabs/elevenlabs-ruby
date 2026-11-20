# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TtsConversationalConfigOverrideTest < Minitest::Test
  def test_round_trip
    wire = { 'model_id' => 'eleven_turbo_v2', 'voice_id' => 'test-value', 'supported_voices' => [{ 'label' => 'test-value', 'voice_id' => 'test-value', 'description' => 'test-value', 'language' => 'test-value', 'model_family' => 'turbo', 'optimize_streaming_latency' => 0, 'stability' => 0, 'speed' => 0.7, 'similarity_boost' => 0, 'clone_strength' => 0 }], 'stability' => 1, 'speed' => 1, 'similarity_boost' => 1, 'clone_strength' => 1, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::TtsConversationalConfigOverride.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
