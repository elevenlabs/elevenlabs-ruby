# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationConfigClientOverrideConfigInputTest < Minitest::Test
  def test_round_trip
    wire = { 'asr' => { 'keywords' => true }, 'turn' => { 'soft_timeout_config' => { 'message' => true, 'additional_soft_timeout_messages' => true }, 'noisy_environment_message' => true }, 'tts' => { 'model_id' => true, 'voice_id' => true, 'supported_voices' => true, 'stability' => true, 'speed' => true, 'similarity_boost' => true, 'clone_strength' => true, 'pronunciation_dictionary_locators' => true }, 'conversation' => { 'text_only' => true, 'max_duration_seconds' => true }, 'agent' => { 'first_message' => true, 'language' => true, 'max_conversation_duration_message' => true, 'prompt' => { 'prompt' => true, 'llm' => true, 'reasoning_effort' => true, 'tool_ids' => true, 'tool_ids_strict' => true, 'native_mcp_server_ids' => true, 'knowledge_base' => true } } }

    instance = ::Elevenlabs::Types::ConversationConfigClientOverrideConfigInput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
