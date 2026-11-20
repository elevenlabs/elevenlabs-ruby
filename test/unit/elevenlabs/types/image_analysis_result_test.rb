# frozen_string_literal: true

require 'elevenlabs'
require 'minitest/autorun'

# Round-trip test generated for FSDK-1716. Proves the model's deserialize/serialize pair is
# actually wire-shaped -- not just that it runs -- by asserting the exact wire hash it started
# from comes back out unchanged.
class ImageAnalysisResultTest < Minitest::Test
  def test_round_trip
    wire = { 'title' => 'test-value', 'description' => 'test-value', 'content_type' => 'test-value', 'mood_and_style' => 'test-value', 'composition_notes' => 'test-value', 'visible_text' => 'test-value', 'subjects' => [{ 'name' => 'test-value', 'description' => 'test-value' }] }

    instance = ::Elevenlabs::Types::ImageAnalysisResult.new(wire)

    assert_equal(wire, instance.to_h)
  end
end
