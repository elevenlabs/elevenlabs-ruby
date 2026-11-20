# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ImageAnalysisTest < Minitest::Test
  def test_round_trip
    wire = { 'status' => 'processing', 'data' => { 'title' => 'test-value', 'description' => 'test-value', 'content_type' => 'test-value', 'mood_and_style' => 'test-value', 'composition_notes' => 'test-value', 'visible_text' => 'test-value', 'subjects' => [{ 'name' => 'test-value', 'description' => 'test-value' }] }, 'updated_at_ms' => 1 }

    instance = ::Elevenlabs::Types::ImageAnalysis.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
