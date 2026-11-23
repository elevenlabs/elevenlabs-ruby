# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ConversationInitiationClientDataConversationConfigOverrideAgentPromptTest < Minitest::Test
  def test_round_trip
    wire = { 'prompt' => 'test-value', 'llm' => 'gpt-4o-mini', 'reasoning_effort' => 'none', 'tool_ids' => ['test-value'], 'tool_ids_strict' => true, 'native_mcp_server_ids' => ['test-value'], 'knowledge_base' => [{ 'type' => 'file', 'name' => 'test-value', 'id' => 'test-value', 'usage_mode' => 'prompt' }] }

    instance = ::Elevenlabs::Types::ConversationInitiationClientDataConversationConfigOverrideAgentPrompt.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
