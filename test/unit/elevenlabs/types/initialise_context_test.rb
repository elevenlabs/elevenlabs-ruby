# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class InitialiseContextTest < Minitest::Test
  def test_round_trip
    wire = { 'text' => 'test-value', 'voice_settings' => { 'stability' => 1, 'similarity_boost' => 1, 'style' => 1, 'use_speaker_boost' => true, 'speed' => 1 }, 'generation_config' => { 'chunk_length_schedule' => [1] }, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }], 'xi_api_key' => 'test-value', 'authorization' => 'test-value', 'context_id' => 'test-value' }

    instance = ::Elevenlabs::Types::InitialiseContext.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
