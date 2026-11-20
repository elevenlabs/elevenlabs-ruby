# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class AgentKnowledgeBaseRagChunkResponseModelTest < Minitest::Test
  def test_round_trip
    wire = { 'document_id' => 'test-value', 'document_name' => 'test-value', 'source_url' => 'test-value', 'chunk_id' => 'test-value', 'text' => 'test-value', 'vector_distance' => 1, 'content_format' => 'html', 'document_type' => 'file' }

    instance = ::Elevenlabs::Types::AgentKnowledgeBaseRagChunkResponseModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
