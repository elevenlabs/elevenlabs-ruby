# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ElevenV3RequestTest < Minitest::Test
  def test_round_trip
    wire = { 'webhook' => { 'type' => 'all' }, 'text' => 'test-value', 'voice' => 'test-value', 'output_format' => 'mp3_22050_32', 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'model_id' => 'eleven_v3', 'language_code' => 'test-value', 'voice_settings' => { 'stability' => 0 } }

    instance = ::Elevenlabs::Types::ElevenV3Request.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
