# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentKnowledgeBaseRagQueryResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'strategy' => 'cat', 'retrieval_query' => 'test-value', 'chunks' => [{ 'document_id' => 'test-value', 'document_name' => 'test-value', 'source_url' => 'test-value', 'chunk_id' => 'test-value', 'text' => 'test-value', 'vector_distance' => 1, 'content_format' => 'html', 'document_type' => 'file' }], 'document' => { 'document_id' => 'test-value', 'document_name' => 'test-value', 'source_url' => 'test-value', 'content' => 'test-value', 'truncated' => true, 'content_format' => 'html', 'document_type' => 'file' }, 'listing' => { 'entries' => [{ 'id' => 'test-value', 'name' => 'test-value', 'is_folder' => true }], 'total_count' => 1 } }

    instance = ::Elevenlabs::Types::AgentKnowledgeBaseRagQueryResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
