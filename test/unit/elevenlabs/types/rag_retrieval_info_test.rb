# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RagRetrievalInfoTest < Minitest::Test
  def test_round_trip
    wire = { 'chunks' => [{ 'document_id' => 'test-value', 'chunk_id' => 'test-value', 'vector_distance' => 1 }], 'embedding_model' => 'e5_mistral_7b_instruct', 'retrieval_query' => 'test-value', 'rag_latency_secs' => 1, 'used_chunk_ids' => ['test-value'] }

    instance = ::Elevenlabs::Types::RagRetrievalInfo.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
