# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentMessagesOverridesTest < Minitest::Test
  def test_round_trip
    wire = { 'prompt' => 'test-value', 'llm' => 'gpt-4o-mini', 'language' => 'test-value', 'tool_ids' => ['test-value'], 'native_mcp_server_ids' => ['test-value'], 'knowledge_base_ids' => ['test-value'], 'procedure_ids' => ['test-value'], 'custom_llm_extra_body' => {} }

    instance = ::Elevenlabs::Types::AgentMessagesOverrides.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
