# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class PromptAgentAPIModelOverrideConfigTest < Minitest::Test
  def test_round_trip
    wire = { 'prompt' => true, 'llm' => true, 'reasoning_effort' => true, 'tool_ids' => true, 'tool_ids_strict' => true, 'native_mcp_server_ids' => true, 'knowledge_base' => true }

    instance = ::Elevenlabs::Types::PromptAgentAPIModelOverrideConfig.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
