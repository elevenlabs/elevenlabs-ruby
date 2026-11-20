# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentKnowledgeBaseRagQueryRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'strategy' => 'cat', 'query' => 'test-value', 'documents' => ['test-value'], 'use_agent_defaults' => true, 'max_documents_length' => 50_000, 'max_retrieved_rag_chunks_count' => 20 }

    instance = ::Elevenlabs::Types::AgentKnowledgeBaseRagQueryRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
