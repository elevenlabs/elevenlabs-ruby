# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class GenerationChunkOutputTest < Minitest::Test
  def test_round_trip
    wire = { 'text' => 'test-value', 'duration_ms' => 3000, 'positive_styles' => ['test-value'], 'negative_styles' => ['test-value'], 'context_adherence' => 'low', 'conditioning_ref' => { 'song_id' => 'test-value', 'range' => { 'start_ms' => 1, 'end_ms' => 1 } }, 'condition_strength' => 'low' }

    instance = ::Elevenlabs::Types::GenerationChunkOutput.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
