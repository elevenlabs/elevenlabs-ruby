# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class RagChunkMetadataTest < Minitest::Test
  def test_round_trip
    wire = { 'document_id' => 'test-value', 'chunk_id' => 'test-value', 'vector_distance' => 1 }

    instance = ::Elevenlabs::Types::RagChunkMetadata.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
