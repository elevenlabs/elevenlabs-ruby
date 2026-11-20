# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ReceptionCustomerFacingConfigPatchTest < Minitest::Test
  def test_round_trip
    wire = { 'additional_instructions' => 'test-value', 'tone_traits' => ['test-value'], 'details_to_collect' => ['test-value'], 'llm' => 'gpt-4o-mini', 'reasoning_effort' => 'none', 'disable_rag' => true, 'background_voice_detection' => true, 'turn_eagerness' => 'patient', 'voice_id' => 'test-value', 'language' => 'test-value', 'additional_languages' => ['test-value'], 'first_message' => 'test-value', 'first_message_mode' => 'interruptible', 'enable_end_call_tool' => true, 'enable_skip_turn_tool' => true, 'enable_play_keypad_touch_tone_tool' => true, 'hide_caller_number_on_transfers' => true, 'record_after_transfers' => true, 'enable_secure_mode' => true, 'enable_spam_protection' => true }

    instance = ::Elevenlabs::Types::ReceptionCustomerFacingConfigPatch.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
