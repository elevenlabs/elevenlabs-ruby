# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class KnowledgeBaseToolResultModelTest < Minitest::Test
  def test_round_trip
    wire = { 'result_type' => 'knowledge_base_success', 'status' => 'success', 'chunk_count' => 1, 'message' => 'test-value' }

    instance = ::Elevenlabs::Types::KnowledgeBaseToolResultModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
