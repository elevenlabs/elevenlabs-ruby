# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TtsConversationalConfigOverrideConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'model_id' => true, 'voice_id' => true, 'supported_voices' => true, 'stability' => true, 'speed' => true, 'similarity_boost' => true, 'clone_strength' => true, 'pronunciation_dictionary_locators' => true }

    instance = ::Elevenlabs::Types::TtsConversationalConfigOverrideConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
