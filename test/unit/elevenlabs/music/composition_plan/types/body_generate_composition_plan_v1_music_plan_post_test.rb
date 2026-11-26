# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class BodyGenerateCompositionPlanV1MusicPlanPostTest < Minitest::Test
  def test_round_trip
    wire = { 'prompt' => 'test-value', 'music_length_ms' => 3000, 'source_composition_plan' => { 'positive_global_styles' => ['test-value'], 'negative_global_styles' => ['test-value'], 'sections' => [{ 'section_name' => 'test-value', 'positive_local_styles' => ['test-value'], 'negative_local_styles' => ['test-value'], 'duration_ms' => 3000, 'lines' => ['test-value'], 'source_from' => { 'song_id' => 'test-value', 'range' => { 'start_ms' => 1, 'end_ms' => 1 }, 'negative_ranges' => [{ 'start_ms' => 1, 'end_ms' => 1 }] } }] }, 'model_id' => 'music_v1' }

    instance = ::Elevenlabs::Music::CompositionPlan::Types::BodyGenerateCompositionPlanV1MusicPlanPost.new(wire)

    assert_equal(wire, instance.to_h.except('enable_logging'))
  end
end
