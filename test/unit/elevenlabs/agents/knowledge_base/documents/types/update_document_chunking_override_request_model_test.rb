# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class UpdateDocumentChunkingOverrideRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'chunking_override' => { 'max_chunk_size' => 200, 'overlap_percentage' => 0, 'custom_separators' => ['test-value'] } }

    instance = ::Elevenlabs::Agents::KnowledgeBase::Documents::Types::UpdateDocumentChunkingOverrideRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
