# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ChunkingOverrideRequestModelTest < Minitest::Test
  def test_round_trip
    wire = { 'max_chunk_size' => 200, 'overlap_percentage' => 0, 'custom_separators' => ['test-value'] }

    instance = ::Elevenlabs::Types::ChunkingOverrideRequestModel.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
