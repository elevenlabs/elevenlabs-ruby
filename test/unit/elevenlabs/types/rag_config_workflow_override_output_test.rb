# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RagConfigWorkflowOverrideOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'enabled' => true, 'embedding_model' => 'e5_mistral_7b_instruct', 'max_vector_distance' => 1, 'max_documents_length' => 1, 'max_retrieved_rag_chunks_count' => 1, 'num_candidates' => 1, 'query_rewrite_prompt_override' => 'test-value', 'knowledge_base_tool_info' => { 'enabled_strategies' => ['cat'] } }

    instance = ::Elevenlabs::Types::RagConfigWorkflowOverrideOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
