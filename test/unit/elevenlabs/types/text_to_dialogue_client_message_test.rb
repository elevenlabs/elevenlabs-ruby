# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class TextToDialogueClientMessageTest < Minitest::Test
  def test_round_trip
    wire = { 'inputs' => [{ 'text' => 'test-value', 'voice_id' => 'test-value', 'new_turn' => true }], 'flush' => true, 'close_socket' => true, 'keep_alive' => true, 'xi_api_key' => 'test-value', 'authorization' => 'test-value', 'single_use_token' => 'test-value', 'voices' => ['test-value'], 'voice_settings' => { 'stability' => 0 }, 'pronunciation_dictionary_locators' => [{ 'pronunciation_dictionary_id' => 'test-value', 'version_id' => 'test-value' }] }

    instance = ::Elevenlabs::Types::TextToDialogueClientMessage.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
